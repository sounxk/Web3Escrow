//SPDX-License-Identifier:MIT

pragma solidity ^0.8.10;

contract Escrow {

    //transaction status
    enum EscrowStatus { Created, Locked, Released, Refunded, Dispute }

    //transaction block
    struct EscrowTransaction {
        address buyer;
        address seller;
        address arbitrator;
        uint256 amount;
        EscrowStatus status;
    }



    //keeping track of the transactions

    mapping (bytes32 => EscrowTransaction) private escrowTransactions;

    

    //modifiers

    modifier onlyBuyer(bytes32 transactionId) {
        require(msg.sender == escrowTransactions[transactionId].buyer, "Only the buyer can perform this action.");
        _;
    }

    modifier onlySeller(bytes32 transactionId) {
        require(msg.sender == escrowTransactions[transactionId].seller, "Only the seller can perform this action.");
        _;
    }

    modifier onlyArbitrator(bytes32 transactionId) {
        require(msg.sender == escrowTransactions[transactionId].arbitrator, "Only the arbitrator can perform this action.");
        _;
    }

    modifier inStatus(bytes32 transactionId, EscrowStatus status) {
        require(escrowTransactions[transactionId].status == status, "Transaction is not in the required state.");
        _;
    }


    //escrow creation function

    event EscrowCreated(bytes32 indexed transactionId, address indexed buyer, address indexed seller, uint256 amount);

    function createEscrow(bytes32 transactionId, address buyer, address seller, address arbitrator) external payable {
        require(escrowTransactions[transactionId].buyer == address(0), "Transaction ID already exists.");

        escrowTransactions[transactionId] = EscrowTransaction({
            buyer: buyer,
            seller: seller,
            arbitrator: arbitrator,
            amount: msg.value,
            status: EscrowStatus.Created
        });

        emit EscrowCreated(transactionId, buyer, seller, msg.value);
    }


    event EscrowLocked(bytes32 indexed transactionId);

    function lockEscrow(bytes32 transactionId) external onlySeller(transactionId) inStatus(transactionId, EscrowStatus.Created) {
        escrowTransactions[transactionId].status = EscrowStatus.Locked;

        emit EscrowLocked(transactionId);
    }



    event EscrowReleased(bytes32 indexed transactionId);

    function releaseEscrow(bytes32 transactionId) external onlyBuyer(transactionId) inStatus(transactionId, EscrowStatus.Locked) {
        escrowTransactions[transactionId].status = EscrowStatus.Released;

        address payable seller = payable(escrowTransactions[transactionId].seller);
        uint256 amount = escrowTransactions[transactionId].amount;

        seller.transfer(amount);

        emit EscrowReleased(transactionId);
    }




    event EscrowRefunded(bytes32 indexed transactionId);

    function refundEscrow(bytes32 transactionId) external onlySeller(transactionId) inStatus(transactionId, EscrowStatus.Locked) {
        escrowTransactions[transactionId].status = EscrowStatus.Refunded;

        address payable buyer = payable(escrowTransactions[transactionId].buyer);
        uint256 amount = escrowTransactions[transactionId].amount;

        buyer.transfer(amount);

        emit EscrowRefunded(transactionId);
    }



    event EscrowDisputed(bytes32 indexed transactionId);

    function initiateDispute(bytes32 transactionId) external onlyArbitrator(transactionId) inStatus(transactionId, EscrowStatus.Locked) {
        escrowTransactions[transactionId].status = EscrowStatus.Dispute;

        emit EscrowDisputed(transactionId);
    }




    event EscrowResolved(bytes32 indexed transactionId, address indexed resolver, bool releasedFunds);

    function resolveDispute(bytes32 transactionId, bool releaseFunds) external onlyArbitrator(transactionId) inStatus(transactionId, EscrowStatus.Dispute) {
        escrowTransactions[transactionId].status = EscrowStatus.Released;

        address payable seller = payable(escrowTransactions[transactionId].seller);
        address payable buyer = payable(escrowTransactions[transactionId].buyer);
        uint256 amount = escrowTransactions[transactionId].amount;

        if (releaseFunds) {
            seller.transfer(amount);
        } else {
            buyer.transfer(amount);
        }

        emit EscrowResolved(transactionId, msg.sender, releaseFunds);
    }



    function getEscrowStatus(bytes32 transactionId) external view returns (EscrowStatus) {
        return escrowTransactions[transactionId].status;
    }
}
