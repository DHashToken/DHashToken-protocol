// Copyright 2017 DHashToken Ltd.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ----------------------------------------------------------------------------
// test/SimpleToken_utils.js
//
// http://www.simpletoken.org/
//
// ----------------------------------------------------------------------------

const Assert = require('assert');
const BigNumber = require('bignumber.js');

var SimpleToken = artifacts.require("./SimpleToken/SimpleToken.sol");

/// @dev currently unused as tests for SimpleToken.js don't
///      follow this paradigm - to align
module.exports.deploySimpleToken = async (artifacts, accounts) => {

   const token = await SimpleToken.new({ from: accounts[0], gas: 3500000 });

   return {
      token : token
   }
}

/// @dev Assert on Transfer event
module.exports.checkTransferEventGroup = (result, _from, _to, _value) => {
   Assert.equal(result.logs.length, 1);

   const event = result.logs[0];

   module.exports.checkTransferEvent(event, _from, _to, _value);
}


module.exports.checkTransferEvent = (event, _from, _to, _value) => {
   if (Number.isInteger(_value)) {
      _value = new BigNumber(_value);
   }
   Assert.equal(event.event, "Transfer");
   Assert.equal(event.args._from, _from);
   Assert.equal(event.args._to, _to);
   Assert.equal(event.args._value.toNumber(), _value.toNumber());
}


module.exports.checkApprovalEventGroup = (result, _owner, _spender, _value) => {
   assert.equal(result.logs.length, 1)

   const event = result.logs[0]

   if (Number.isInteger(_value)) {
      _value = new BigNumber(_value)
   }

   assert.equal(event.event, "Approval")
   assert.equal(event.args._owner, _owner)
   assert.equal(event.args._spender, _spender)
   assert.equal(event.args._value.toNumber(), _value.toNumber())
}

module.exports.checkFinalizedEventGroup = (result) => {
   assert.equal(result.logs.length, 1)

   const event = result.logs[0]

   assert.equal(event.event, "Finalized")
}


module.exports.checkBurntEventGroup = (result, _from, _value) => {
   assert.equal(result.logs.length, 1)

   const event = result.logs[0]

   assert.equal(event.event, "Burnt")
   assert.equal(event._from, _from)
   assert.equal(event._value, _value)
}