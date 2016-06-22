## Trusted Address v.0.1

The TrustedAddress Smart Contract is based around an extremely simple Web of Trust idea: voting between Ethereum addresses. Each Ethereum address can cast a vote of trust towards any other address, using a trinary system of choices:

  * Vote of trust:  1
  * Neutral or reset:  0
  * Vote of distrust:  -1

From the smart contract we can retrive data to form a trust based matrix:
Most of the computational work to retrive a trust model can be done in the future from an interface, through matrix manipulation.


## Code Walkthrough

The voter, which is the sender, is added to the voters array if he/she hasn't voted before. The vote is pushed into the array of votes corrisponding to the voter address, but only if there is no previous vote casted toward that account from that sender.


```solidity
contract TrustedAddress {

    address[] voters;
    mapping(address => address[]) votes;
    mapping(address => mapping(address => int8)) votesMap;
    //The vote function takes as an argument the address we want to vote for and the vote.
    function vote(address voteFor, int vote) {

        address voter   = msg.sender;
        address[] myVotes = votes[voter];

        if (myVotes.length == 0) {
            voters.push(voter);
        }

        if (votesMap[voter][voteFor] == 0) {
            myVotes.push(voteFor);
        }

        if(vote == 0) {
            votesMap[voter][voteFor] = 0;
        } else if (vote > 0) {
            votesMap[voter][voteFor] = 1;
        } else {
            votesMap[voter][voteFor] = -1;
        }
    }

    function totalVoters() constant returns (uint) {
        return voters.length;
    }

    function votersOfIndex(uint index) constant returns (address) {
        return voters[index];
    }

    function totalVotesOf(address voter) constant returns (uint) {
        return votes[voter].length;
    }

    function votesOf(address voter, uint index) constant returns (address, int8) {
        address voted = votes[voter][index];
        return (voted, votesMap[voter][voted]);
    }

    function deleteEquals(address voter, uint index1, uint index2) {
        address[] myVotes = votes[voter];
        address add1 = myVotes[index1];
        address add2 = myVotes[index2];
        if(add1 == add2 && add1 != 0 && index1 != index2) {
            myVotes[index1] = myVotes[myVotes.length-1];
            myVotes.length--;
        }
    }
```


## Interactions through JS-console

We wanted to keep it simple. There is no web interface to interact with the contract, but interaction can happen through Geth or Parity console.

```js
var contrAddr = /* Address*/;
var ABI = /*Replace with interface string */;
var trustedAddress = eth.contract(ABI).at(contrAddr);
```

You can now vote using the following method:

```js
var voteFor = /*Address you want to vote for */;
var vote = /* Vote to be casted: it can only be 1,0 and -1*/;
trustedAddress.vote(voteFor, vote, {from: eth.accounts[0], gas: 140000});
```


## Issues and Improvements
Currently, it's clearly not Sybil Attack resistant:
you can create a number of addresses and vote as much as you want. It could be possible to build a smart contract which can bridge with Proof-of-Identity, e.g the Estonian ID system as shown [here](https://github.com/oraclize/dapp-proof-of-identity).

Riccardo Casatta e Marco Giglio
