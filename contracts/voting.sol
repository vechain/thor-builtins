pragma solidity ^0.4.23;


interface Voting {    
    function startPoll(uint _numOptions, uint _revealedQuorum, uint _commitDuration, uint _revealDuration) external;
    function commitVote(uint _pollID, bytes32 _secretHash) external;
    function revealVote(uint _pollID, uint _voteOption, uint _salt) external;
    function winner(uint _pollID) view external returns (uint);
}