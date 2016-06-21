contract TrustedAddress {

    address[] voters;
    mapping(address => address[]) votes;
    mapping(address => mapping(address => int8)) votesMap;

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

}
