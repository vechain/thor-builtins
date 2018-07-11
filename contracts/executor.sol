pragma solidity ^0.4.23;


interface Executor {    
    function propose(address _target, bytes _data) external returns(bytes32);
    function approve(bytes32 _proposalID) external;
    function execute(bytes32 _proposalID) external;
    function addApprover(address _approver, bytes32 _identity) external;
    function revokeApprover(address _approver) external;
    function attachVotingContract(address _contract) external;
    function detachVotingContract(address _contract) external;
}