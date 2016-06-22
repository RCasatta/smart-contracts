## Trusted Address v.0.1

The TrustedAddress Smart Contract is based around an extremely simple Web of Trust idea: voting between Ethereum addresses. Each Ethereum address can cast a vote of trust towards any other address, using a trinary system of choices:

  * Vote of trust:  1
  * Neutral or reset:  0
  * Vote of distrust:  -1

The contract has been deployed on Morden testnet at address [0xd2f068a3b3cffafed8880cfd92715602bd0c0ef0](https://morden.ether.camp/account/d2f068a3b3cffafed8880cfd92715602bd0c0ef0).
## The commented code

```solidity
contract TrustedAddress {

    address[] votersArray;
    mapping(address => address[]) votesOf;
    mapping(address => mapping(address => int8)) votesMapOf;

    //The function takes as an argument the address we want to vote for and
    //a vote.

    function vote(address voteFor, int vote) {
        address currentVoter   = msg.sender;

        //If the currentVoter address hasn't voted before, add it to the votersArray
        if (votesOf[currentVoter].length == 0) {
            votersArray.push(currentVoter);
        }
        //If no vote was casted toward this address, add vote in the voter's votes array
        if (votesMapOf[currentVoter][voteFor] == 0) {
            votesOf[currentVoter].push(voteFor);
        }
        // Add vote to the mapping
        if(vote == 0) {
            votesMapOf[currentVoter][voteFor] = 0;
        } else if (vote > 0) {
            votesMapOf[currentVoter][voteFor] = 1;
        } else {
            votesMapOf[currentVoter][voteFor] = -1;
        }
    }

    function totalVoters() constant returns (uint) {
        return votersArray.length;
    }

    function voterOfIndex(uint index) constant returns (address) {
        return votersArray[index];
    }

    function totalVotesOf(address currentVoter) constant returns (uint) {
        return votesOf[currentVoter].length;
    }
    // Given an address and an index, it will return the i-th casted vote by that address
    function votesMap(address currentVoter, uint index) constant returns (address, int8) {
        address votedAddr = votesOf[currentVoter][index];
        return (votedAddr, votesMapOf[currentVoter][votedAddr]);
    }
    /* If an address has casted multiple votes toward the same address,
    they will remain in its vote array. This method can help clean the matrix
    */
    function deleteEquals(address currentVoter, uint index1, uint index2) {
        address[] myVotes = votesOf[currentVoter];
        address add1 = myVotes[index1];
        address add2 = myVotes[index2];
        if(add1 == add2 && add1 != 0 && index1 != index2) {
            myVotes[index1] = myVotes[myVotes.length-1];
            myVotes.length--;
        }
    }

}
```


## Interactions through JS-console

We wanted to keep it simple. There is no web interface to interact with the contract, but interaction can happen through Geth or Parity console.

```js
var contrAddr = '0xd2f068a3b3cffafed8880cfd92715602bd0c0ef0';
var ABI = /*Replace with interface string from file */;
var trustedAddress = eth.contract(ABI).at(contrAddr);
```

You can now vote using the following method:

```js
var voteFor = /*Address you want to vote for */;
var vote = /* Vote to be casted: it can only be 1,0 and -1*/;
trustedAddress.vote(voteFor, vote, {from: eth.accounts[0], gas: 140000});
```

## Improvements
Currently, it's clearly not fully Sybil Attack resistant. Although there is a small cost which has to be spent by each transaction, nothing prevents someone to pollute the contract with thousands of fake votes, paying the due amount of gas. But on the client-side is possible to filter and perform computation on the data, for example:
  * We could consider only the votes of addresses we trust in first place: e.g friends, developers, community leaders
  * The data structure chosen enables client-side collaborative filtering
  * In the future, it could be possible to build an integration with Proof-of-Identity systems.

Riccardo Casatta e Marco Giglio
