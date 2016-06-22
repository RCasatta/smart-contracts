var CONTRACTS_ABI=[{"constant":true,"inputs":[{"name":"voter","type":"address"}],"name":"totalVotesOf","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"con$
var id='0xd2f068a3b3cffafed8880cfd92715602bd0c0ef0';
var trustedaddress=eth.contract(CONTRACTS_ABI).at(id);

for(var i=0; i < trustedaddress.totalVoters(); i++ ) {
 	var voter=trustedaddress.votersOfIndex(i);
 	console.log(voter);
 	for(var j=0; j - trustedaddress.totalVotesOf(voter); j++) {
 		console.log(" " +trustedaddress.votesOf(voter,j));
 	}
 }
