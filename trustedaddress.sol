contract TrustedAddress {

    address[] voters;
    mapping(address => address[]) votes;
    mapping(address => mapping(address => bool)) votesMap;

    function voteNo(address voteFor) {
        votesMap[msg.sender][voteFor] = false;
    }

    function voteYes(address voteFor) {
        var voter   = msg.sender;
        var myVotes = votes[voter];
        
        if (myVotes.length == 0) {
            voters[voters.length++] = voter;
        }
        
        if (!votesMap[voter][voteFor]) {
            myVotes[myVotes.length++] = voteFor;
        }
        
        votesMap[voter][voteFor] = true;
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
    
    function votesOf(address voter, uint index) constant returns (address,bool) {
        address voted = votes[voter][index];
        return (voted,votesMap[voter][voted]);
    }

}

