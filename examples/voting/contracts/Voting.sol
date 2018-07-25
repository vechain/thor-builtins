pragma solidity ^0.4.22;

import "../../../contracts/builtin.sol";

/// @title Voting intends to modify governance params 'BaseGasPrice' in VechainThor by executor.
/// First a voting will be proposed by an approver, and the approvers will vote it in a week.
/// If two thirds of approvers approver the voting, the voting can be executed.

contract Owned {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

}

/// @notice The Target contract will be executed if the voting is passed.
contract Target is Owned{
    uint256 constant targetBaseGasPrice = 1e14;
    bytes32 constant KeyBaseGasPrice = bytes32("base-gas-price");

    Params params = Builtin.getParams();

    /// @notice Only the executor have authority to execute it.
    function updateBaseGasPrice() public {
        params.set(KeyBaseGasPrice, targetBaseGasPrice);
    }
}

contract Voting is Owned{
    Target target;
    bytes32 proposalID;
    Executor executor = Builtin.getExecutor();
    uint64 startTime;

    /// @notice propose a voting
    function propose() public onlyOwner {
        proposalID = executor.propose(address(target), abi.encodePacked(keccak256("updateBaseGasPrice()")));
        startTime = uint64(now);
    }

    /// @notice The voting must be finished in a week.
    function isExpired() public view returns(bool){
        return startTime + uint64(1 weeks) > uint64(now);
    }

    /// @notice execute target proposalID
    function execute() public onlyOwner {
        executor.execute(proposalID);
    }

    /// @notice The msg sender who is one of the executive committee in VechainThor will approve the voting.
    function approve() public {
        executor.approve(proposalID);
    }
}
