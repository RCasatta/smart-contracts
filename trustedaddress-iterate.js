var CONTRACTS_ABI=[{"constant":true,"inputs":[{"name":"voter","type":"address"}],"name":"totalVotesOf","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"voter","type":"address"},{"name":"index1","type":"uint256"},{"name":"index2","type":"uint256"}],"name":"deleteEquals","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"totalVoters","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[{"name":"voter","type":"address"},{"name":"index","type":"uint256"}],"name":"votesOf","outputs":[{"name":"","type":"address"},{"name":"","type":"int8"}],"type":"function"},{"constant":true,"inputs":[{"name":"index","type":"uint256"}],"name":"votersOfIndex","outputs":[{"name":"","type":"address"}],"type":"function"},{"constant":false,"inputs":[{"name":"voteFor","type":"address"},{"name":"vote","type":"int256"}],"name":"vote","outputs":[],"type":"function"}]
var id='0xd2f068a3b3cffafed8880cfd92715602bd0c0ef0';
var trustedaddress=eth.contract(CONTRACTS_ABI).at(id);

for(var i=0; i < trustedaddress.totalVoters(); i++ ) {
 	var voter=trustedaddress.votersOfIndex(i);
 	console.log(voter);
 	for(var j=0; j - trustedaddress.totalVotesOf(voter); j++) {
 		console.log(" " +trustedaddress.votesOf(voter,j));
 	}
 }