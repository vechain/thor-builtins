# thor-builtins

The built-in contracts for Vechain include: 
 - `authority.sol`
 - `energy.sol`
 - `extension.sol`
 - `params.sol`
 - `prototype.sol`
 - `executor.sol` 
    
You can check the source code of these contracts by visiting: https://github.com/vechain/thor/blob/master/builtin/gen. We will give a detailed description of these contracts and teach you how to use it in your dapp. Some simple examples generated by truffle will be given and you can run it on the VechainThor testnet.

## built-in contracts
- `authority.sol`

    Authority is related to the POA (Proof of Authority) consensus mechanism.
The Authority contract manages a list of candidates proposers who are responsible for packing transactions into a block.
The proposers are authorized by a voting committee, but only the first 101 proposers in the candidates list can pack a block.
A candidates proposer includes signer address, endorsor address and identity.
Signer address is releated to signing a block, endorsor address is used for charging miner fees and identity is used for identifying the proposer.

- `energy.sol`

    Energy represents the sub-token in VeChainThor which conforms to the VIP180 (ERC20) standard.
The name of token is "VeThor" and 1 THOR equals to 1e18 wei. The main function of VeThor is to pay for the transaction fee. 
VeThor is generated from VET, so the initial supply of VeThor is zero in the genesis block.
The growth rate of VeThor is 5000000000 wei per token (VET) per second, that is to say 1 VET will produce about 0.000432 THOR per day.
The miner will charge 30 percent of transation fee and 70 percent will be burned. So the total supply of VeThor is dynamic.

- `extension.sol`

    Extension extends EVM functions.
Extension gives the opportunity for a developer to get information about the current transaction and the history of any block within the range of genesis to the "best" block.
The information obtained based on the block numer includes blockID, blockTotalScore, blockTime and blockSigner.
The developer can also get the current transaction information, including txProvedWork, txID, txBlockRef and txExpiration.

- `params.sol`

    Params stores the governance params of VeChain Thor.
The params can be set by the executor, a contract that is authorized to modify governance params by a voting Committee.
Anyone can get the params just by calling "get" funtion.
The governance params are written in genesis block at launch time.
You can check these params at source file: https://github.com/vechain/thor/blob/master/thor/params.go.

- `prototype.sol`

    Prototype is an account management model of VeChainThor.
In the account management model every contract has a master account, which, by default, is the creator of a contract.

   The master account plays the role of a contract manager, which has some authorities including:

    - `setMaster`
    - `setCreditPlan` 
    - `addUser` 
    - `removeUser` 
    - `selectSponsor`
 
   Every contract keeps a list of users who can call the contract for free but are limited by credit.
   The user of a specific contract can be either added or removed by the contract master.
   Although from a user's perspective the fee is free, it is paid by a sponsor of the contract.
   Any one can be a sponser of a contract, just by calling sponsor function and can be cancelled by calling the unsponsor function.
   A contract may have more than one sponsors, but only the current sponsor chosen by master needs to pay the fee for the contract.
   If the current sponsor is out of energy, the master can select a sponser from other sponser candidates by calling the selectSponsor function.
   The creditPlan can be set by the master which includes credit and recoveryRate. Every user has the same original credit.
   Every Transaction consumes some amount of credit which is equal to the fee of the Transaction, and the user can also pay the fee by itself if the gas payer is out of the credit. 
   The credit can be recovered based on recoveryRate (per block).

- `executor.sol`

    Executor represents the core component for on-chain governance. 
The on-chain governance params can be changed by the Executor by calling a proposal on the voting contract.
A executive committee is composed of seven approvers who have been added to the contract Executor in the genesis block.
A new approver can be added and the old approver also can be removed from the executive committee.
The steps of executor include proposing, approving and executing the vote if the proposal is passed.
Only the approvers in the executive committee has the authority to propose and approve a vote.


## Library Builtin
- `builtin.sol`

    The VeChainThor built-in contracts are encapsulated in the library Builtin. It's very easy to use for a developer, just import it.

## How to use it

- `extension`

The contract extension gives extension information about the blockchain including "blockID", "txID", and "blockTotalScore" etc. You can reference these conveniently in your dapp. So for example you have a contract named "Example.sol"

1. Import "Library Builtin" in your solidity code "Example.sol".
    ```
    import "./builtin.sol"
    ```

2. Create your contract "Example" and get instance of extension.
    ```
    contract Example {
        Extension extension = Builtin.getExtension()
    }
    ```
3. In some cases you might want to calculate blake2b-256 checksum of given _data.
    ```
        bytes32 ret = extension.blake2b256(_data);
    ```
4. Get blockID of blockNum
    ```
        bytes32 id = extension.blockID(blockNum);
    ```
5. Get blockTotalScore of blockNum
    ```
        uint64 totalScore = extension.blockTotalScore(blockNum);
    ```
6. Get blockTime of blockNum
    ```
        uint time = extension.blockTime(blockNum);
    ```
7. Get blockSigner of blockNum
    ```
        address signer = extension.blockSigner(blockNum);
    ```
8. Get totalSupply of VET
    ```
        uint256 total = extension.totalSupply();
    ```
9. Get txProvedWork of current transaction
    ```
        uint256 provedWork = extension.txProvedWork();
    ```
10. Get txID of current transaction
    ```
        bytes32 id = extension.txID();
    ```
11. Get txBlockRef of current transaction
    ```
        bytes8 Ref = extension.txBlockRef();
    ```
12. Get txExpiration of current transaction
    ```
        uint expiration = extension.txExpiration();
    ```

- `executor`

Some built-in contracts require the executor to execute it, such as "authority.sol" and "params.sol". We use "executor" including three steps: "propose a voting", "voting by executive committee" and "execute a voting". So you might have a voting contract named "voting.sol".

1. Import "Library Builtin" in your solidity code "voting.sol"
    ```
    import "./builtin.sol"
    ```
2. Create your voting contract and add "propose functon" named "propose".
    ```
    contract voting {
        bytes32 proposalID;
        Executor executor = Builtin.getExecutor();

        function propose(address target, bytes _data) {
            proposalID = executor.propose(target, _data);
        }
    }
    ```
3. The executive committee will approve a voting, so will add approve function named "approve".
    ```
    contract voting {
        ......

        function approve() {
            executor.approve(proposalID);
        }
    }
    ```
4. If a voting is passed in one week, anybody can execute it. So we add the execute function named "execute".
    ```
    contract voting {
        ......

        function execute() {
            executor.execute(proposalID);
        }
    }
    ```

- `authority`

If you want to update an authority node, you should have a target contract, such as "Target.sol". Because only the contract executor has the authority to execute it, so first you should propose a vote to the executor. If the vote passes in a week, you can execute your target contract. Now you can write code like this.

1. Import "Library Builtin" in your solidity code "Target.sol".

    ```
    import "./builtin.sol"
    ```

2. Create your target contract, we named it "Target", and create the target function named "targetFunc". Suppose you want to add "_signer" to the candidate of the authority node.
    ```
    contract Target {
        Authority authority = Builtin.getAuthority();

        function targetFunc() {
            authority.add(_signer, _endorsor, _indentity);
        }
    }
    ```
3. You may be propose a voting by executor, and add the proposing function named "proposeFunc".
    ```
    contract Target {
        ......

        bytes32 proposalID;
        Executor executor = Builtin.getExecutor();
        function proposeFunc() {
            proposalID = executor.propose(address(this), abi.encodePacked(keccak256("targetFunc()")));
        }
    }
    ```
4. If the voting passes in one week, you can execute it, so we should add "execute function" named "executeFunc".
    ```
    contract Target {
        ......

        function executeFunc() {
            executor.execute(proposalID);
        }
    }
    ```
5. Only "add" and "revoke" require the executor, other functions like "get", "first" and "next" are public.

- `params`

The operation of params is very simple, only consisting of "set" and "get". The "set" operation requires the executor.

- `prototype`

The prototype built-in gives extra properties to the contract, such as "master", "user", "sponsor" and "credit". Once a contract is created, the contract has these properties automatically. So for example if you create an empty contract named "EmptyContract".

1. Import "Library Builtin" in your solidity code "EmptyContract.sol".
    ```
    import "./builtin.sol"
    ```

2. Create your "EmptyContract", and using "Library Builtin" for EmptyContract
    ```
    contract EmptyContract {
        using Builtin for EmptyContract;
    }
    ```
3. If you want to know who the master is of the contract, you can call the `this.$master()` function:
    ```
    contract EmptyContract {
        using Builtin for EmptyContract;
        address master = this.$master();
    }
    ```
4. You alse can set a new master to your contract, but the msg sender must be the old master.
    ```
        this.$setMaster(newMaster);
    ```
5. Get the balance of the contract:
    ```
        uint256 blance = this.$balance(block.number);
    ```
6. Get the energy (VTHOR) of the contract:
    ```
        uint256 energy = this.$energy(block.number);
    ```
7. Check storage value by "key".
    ```
        bytes32 value = this.$storageFor(key);
    ```
8. Check creditPlan of a contract.
    ```
        uint256 credit;
        uint256 recoveryRate;
        credit, recoveryRate = this.$creditPlan()
    ```
9. Set a new creditPlan to a contract, but only the master have the authority to do it.
    ```
        this.$setCreditPlan(credit, recoveryRate);
    ```
10. Add a user to a contract, requires the sender to be the master of the contract
    ```
        this.$addUser(newUser);
    ```
11. Remove an old user from contract, requires the sender to be the master of the contract
    ```
        this.$removeUser(oldUser);
    ```
12. Check if somebody is a user of a given contract.
    ```
        bool isUser = this.$isUser(somebody);
    ```
13. Check a users credit (userCredit) of a contract:
    ```
        uint256 credit = this.$userCredit(somebody);
    ```
14. Check if somebody is the sponsor of a contract.
    ```
        bool isSponsor = this.$isSponsor(somebody);
    ```
15. Check who is the currentSponsor.
    ```
        address somebody = this.$currentSponsor();
    ```

## Instance contracts
- `CommodityInfo.sol`

    CommodityInfo stores commodity information in the contract storage.
For example, the information of a commodity is very simple and it includes "id", "originPlace", "productionDate" and "shelfLife".
Only the master or users of the contract have authority to add commodity information.

- `Voting.sol`

    Voting intends to modify governance params "BaseGasPrice" in VechainThor by executor.
First a voting will be proposed by an approver, and the approvers will vote for it over the course of a week.
If two thirds of approvers approver the voting, the vote can be executed.
