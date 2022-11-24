pragma solidity >=0.4.20 <0.9.0;


/// @title A group expenses smart contract allowing you to settle up your debts and credits
/// @author Adrien Arcuri
/// @notice You can use this contract to record your group expenses, Payment participants,
/// check the debts and credits of the groups and settle up.
/// @dev No comments for dev
contract WeExpenses {


    /**
    Participant is a person or an organization which is part of the group expense.
     */
    struct Participant {
        string name;
        address waddress;
        int balance;
        uint index;
    }

    /**
    Expense is cost incurred which will be pay back.
    Expense has an impact on the balance for payer and payee only if payee give its agreement.
     */
    struct Expense {
        string title;
        uint amount;
        uint valueDate;
        uint creationDate;
        address payer; 
        address[] payees; 
        mapping(address => bool) agreements; 
    }

    /**
    Payment is money transfer from one participant to another.
    Payment can be use to settle a debt or a credit.
     */
    struct Payment {
        string title;
        uint amount;
        uint valueDate;
        address payer;
        address payee;
    }

    /// This declares a state variable that stores a `Participant` struct for each possible address.
    mapping(address => Participant) public participants;

    /// This store in an array all the participants
    address[] public addressList;

    /// Allow the creation of the first participant when the contract is deployed
    bool public deployed = false;
    
    // A dynamically-sized array of `Expenses` structs.
    Expense[] public expenses;

    // A dynamically-sized array of `Payments` structs.
    Payment[] public payments;

    // A mapping of all the available withdrawals per address
    mapping(address => uint) public withdrawals;

    /// This modifier requires that the sender of the transaction is registred as participant
    modifier onlyByParticipant () {
        require(msg.sender == participants[msg.sender].waddress || !deployed);
        _;
    }

    

    constructor (string memory name) public{
        createParticipant(name, msg.sender);
        deployed = true;
    }

    /// @notice Create a participant. Only registered participant can add new participant
    /// @param _name the name of the participant
    /// @param _waddress the address of the participant
    function createParticipant(string memory _name, address _waddress) public onlyByParticipant() {
        require(_waddress != participants[_waddress].waddress || !deployed); //only one address per participant
        require(_waddress != address(0)); // avoid to participant address equal to 0x0
        Participant memory participant = Participant({name: _name, waddress: _waddress, balance: 0, index: 0});
        participant.index = addressList.push(_waddress)-1; //add the address to the addressList
        participants[_waddress] = participant;
    }

    /// @notice Create an expense as payer. By default, the payer is the creator of the expense
    /// @dev The number of payees are limited to 20 to avoid gas limit using loop
    /// @param _title the title of the expense
    /// @param _amount the amount of the expense. Must be superior to zero
    /// @param _valueDate the value date of the expense
    /// @param _payees the list of payee of the expense. The payer can be part of the payees
    function createExpense(string memory _title, uint _amount, uint _valueDate, address[] memory _payees) public onlyByParticipant() {
        address _payer = msg.sender;
        require(_amount > 0);
        require(_payees.length > 0 && _payees.length <= 20);
        require(isParticipant(_payer));
        require(isParticipants(_payees));
        require(!isDuplicateInpayees(_payees));

        Expense memory expense = Expense(_title, _amount, _valueDate, now, _payer, _payees);
        expenses.push(expense);
    }

    /// @notice Set participant's agreeement for an expense. Each participant has 4 weeks to set its agreement.
    /// @param indexExpense the index of the expense
    /// @param agree the agreement of the participant : true of false
    function setAgreement(uint indexExpense, bool agree) public onlyByParticipant() {
        Expense storage expense = expenses[indexExpense];
        require(now < expense.creationDate + 4 weeks);
        require(expense.agreements[msg.sender] != agree);
        uint numberOfAgreeBefore = getNumberOfAgreements(indexExpense);
        /// Warning : There is no agreements when the expense is created. That's mean the balance did not synchronize.
        /// If the number of agreements before is not 0, we revert the balance to the previous state without the expense
        if (numberOfAgreeBefore != 0) {
            revertBalance(indexExpense);
        }

        /// Update the number of agreements
        expense.agreements[msg.sender] = agree;
        uint numberOfAgreeAfter = getNumberOfAgreements(indexExpense);

        /// If the number of agreements after is not 0, we syncrhonize the balance
        if (numberOfAgreeAfter != 0) {
            syncBalance(indexExpense);
        }
    }

    /// @notice Create a Payment. Use this payable function send money to the smart contract.
    /// @param _title the title of the payment
    /// @param _payee the payee of the payment
    function createPayment(string memory _title, address _payee) public onlyByParticipant() payable {   
        address _payer = msg.sender;
        require(msg.value > 0);
        require(_payee != _payer);
        require(isParticipant(_payer));
        require(isParticipant(_payee));
        Payment memory payment = Payment({title: _title, amount: msg.value, valueDate: now, payer: _payer, payee: _payee});
        payments.push(payment);
        withdrawals[_payee] += msg.value;
        syncBalancePayment(payment);
    }

    /// @notice Allow each user to withdraw its money from the smart contract
    function withdraw() public onlyByParticipant() {
        require(withdrawals[msg.sender] > 0);
        uint amount = withdrawals[msg.sender];
        withdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    /// @notice Get the max of all balances
    /// @return (max, index) where max is the max of all the balance and index is the index of the participant
    function getMaxBalance() public view returns (int, uint) {
        int max = participants[addressList[0]].balance;
        uint index = 0;
        for (uint i = 1; i < addressList.length; i++) {
            if (max != max256(max, participants[addressList[i]].balance)) {
                max = participants[addressList[i]].balance;
                index = i;
            }
        }
        return (max, index);
    }

    /// @notice Get withdrawal per address
    /// @return the available withdrawal for the waddress
    function getWithdrawal(address waddress) public view returns (uint) {
        return withdrawals[waddress];
    }

    /// @notice Get agreement depending on the indexExpenses and address of the participant
    /// @param indexExpense the index of the expense
    /// @param _waddress address of the payee
    /// @return true if payee gave is agreement, else false
    function getAgreement(uint indexExpense, address _waddress) public view returns (bool) {
        return expenses[indexExpense].agreements[_waddress];
    }

    /// @notice Get the total number of agreements for a given expense
    /// @param indexExpense the index of the expense
    /// @return the number of agreements
    function getNumberOfAgreements(uint indexExpense) public view returns (uint) {
        Expense storage expense = expenses[indexExpense];
        uint numberOfAgreements = 0;
        for (uint i = 0; i < expense.payees.length; i++) {
            if (expense.agreements[expense.payees[i]] == true) {
                numberOfAgreements++;
            }                
        }
        return numberOfAgreements;  
    }

    /// @notice Get balance of a participant
    /// @param _waddress the address of the participant
    /// @return the balance of the participant
    function getBalance(address _waddress) public view returns (int) {
        return participants[_waddress].balance;
    }

    /// @notice Get name of a participant
    /// @param _waddress the address of the participant
    /// @return the name of the participant
    function getParticipantName(address _waddress) public view returns (string memory) {
        return participants[_waddress].name;
    }

    /// @notice Check if there is duplicate inside array
    /// @param list the list of address to check 
    /// @return true if there is duplicate, false otherwise
    function isDuplicateInpayees(address[] memory list) internal pure returns (bool) {
        uint counter;
        for (uint i = 0; i < list.length; i++) {
            counter = 0;
            address addr = list[i];
            for (uint j = 0; j < list.length; j++) {
                if (addr == list[j]) {counter++;}
                if (counter == 2) {return true;}
            }
        }
        return false;
    }

    /// @notice Check if each address of the list is registred as participant
    /// @param list the list of address to check 
    /// @return true if all the list is registred as participant, false otherwise
    function isParticipants(address[] memory list) internal view returns (bool) {
        for (uint i = 0; i < list.length; i++) {
            if (!isParticipant(list[i])) {
                return false;
            }
        }
        return true;
    }

    /// @notice Check if each address of the list is registred as participant
    /// @param _waddress the address to check 
    /// @return true if all the list is registred as participant, false otherwise
    function isParticipant(address _waddress) internal view returns (bool) {
        if (_waddress == participants[_waddress].waddress) {
            return true;
        }else {
            return false;
        }
    }

    /// @notice synchronize balance after each change of the agreements state
    /// @dev This function must be use if there is at list one agreement in the expense
    /// @param indexExpense the index of the expense
    function syncBalance(uint indexExpense) internal {
        calculateBalance(indexExpense, false);
    }

    /// @notice Revert the state of the balance after each change of the agreements state
    /// @dev This function must not be use if there is zero agreement
    /// @param indexExpense the index of the expense
    function revertBalance(uint indexExpense) internal {
        calculateBalance(indexExpense, true);
    }

    /// @notice Calculate the state of the balance after each change of the agreements state (revert or synchornize)
    /// @param indexExpense the index of the expense
    /// @param isRevert indicate if the expense must be reverted or synchronized
    function calculateBalance(uint indexExpense, bool isRevert) internal {
        uint contributors = getNumberOfAgreements(indexExpense);
        require(contributors > 0);
        Expense storage expense = expenses[indexExpense];
        int _portion = int(expense.amount / contributors);
        int _amount = int(expense.amount);
        
        if (isRevert) {
            _portion = -(_portion);
            _amount = -(_amount);
        }

        participants[expense.payer].balance += _amount;
        for (uint i = 0; i < expense.payees.length; i++) {
            if (expense.agreements[expense.payees[i]]) {
                participants[expense.payees[i]].balance -= _portion;
            }   
        }
    }
  
    /// @notice Calculate the state of the balance after each new payement
    /// @param payment which will alter balance
    function syncBalancePayment(Payment memory payment) internal {
        participants[payment.payee].balance -= int(payment.amount);
        participants[payment.payer].balance += int(payment.amount);
    }

    function max256(int256 a, int256 b) internal pure returns (int256) {
        return a >= b ? a : b;
    }

    function min256(int256 a, int256 b) internal pure returns (int256) {
        return a < b ? a : b;
    }    
}