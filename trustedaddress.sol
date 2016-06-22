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
