pragma solidity ^0.4.24;

import "../../../contracts/builtin.sol";

contract Faucet {
    
    using Builtin for Faucet;
    Extension extension = Builtin.getExtension();
    
    address delegator;
    uint256 defaultVETAmount  = 100  * 1000000000000000000;
    uint256 defaultVTHOAmount = 5000 * 1000000000000000000;
    
    constructor() public {
    }
    
    
    function replaceMaster(address _new) public isMaster{
       this.$setMaster(_new);
    }
    
    function getMaster() public view returns(address) {
        return this.$master();
    }
    
    function setDelegator(address _delegator) public isMaster{
        delegator = _delegator;
        emit DelegatorChanged(delegator);
    }
    
    function getDelegator() public view returns(address){
        return delegator;
    }
    
    function getBalance() public view returns(uint256,uint256){
        uint256 vetBalance = address(this).balance;
        uint256 vthoBalance = this.$energy();
        return (vetBalance,vthoBalance);
    }
    
    function deposit() public payable{}
    
    function airdrop() public {
        require((defaultVETAmount <= address(this).balance && defaultVTHOAmount <= this.$energy()),"insufficient balance");
        address(msg.sender).transfer(defaultVETAmount);
        this.$moveEnergyTo(msg.sender,defaultVTHOAmount);
    }
    
    function withdraw(address _receiver) public isMaster{
        address(_receiver).transfer(address(this).balance);
        this.$moveEnergyTo(_receiver,this.$energy());
    }
    
    event DelegatorChanged(address indexed _delegator);
    
    modifier isMaster(){
        require(msg.sender == this.$master(),"permission denied");
        _;
    }
    
    modifier validDelegator(){
        require(extension.txGasPayer() == delegator,"invalid delegator");
        _;
    }
}