var ABI = [{"constant":true,"inputs":[{"name":"currentVoter","type":"address"}],"name":"totalVotesOf","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"currentVoter","type":"address"},{"name":"index1","type":"uint256"},{"name":"index2","type":"uint256"}],"name":"deleteEquals","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"totalVoters","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[{"name":"currentVoter","type":"address"},{"name":"index","type":"uint256"}],"name":"votesMap","outputs":[{"name":"","type":"address"},{"name":"","type":"int8"}],"type":"function"},{"constant":false,"inputs":[{"name":"voteFor","type":"address"},{"name":"vote","type":"int256"}],"name":"vote","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"index","type":"uint256"}],"name":"voterOfIndex","outputs":[{"name":"","type":"address"}],"type":"function"}];

var contrAddr = '0x4d186c43198b3505a41d924a6e2aa6e69d41e978';
var contrTrustedAddr = eth.contract(ABI).at(contrAddr);

for (var i = 0; i < contrTrustedAddr.totalVoters(); i++ ) {
    var voter = contrTrustedAddr.voterOfIndex(i);
 	  console.log(voter);
    for (var j = 0; j - contrTrustedAddr.totalVotesOf(voter); j++) {
        console.log(" " +contrTrustedAddr.votesOf(voter,j));
 	  }
}
