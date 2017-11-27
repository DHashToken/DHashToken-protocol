pragma solidity ^0.4.17;

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
// Common: Core
//
// http://www.simpletoken.org/
//
// ----------------------------------------------------------------------------

import "./CoreInterface.sol";

contract Core is CoreInterface {

	/*
	 *  Structures
	 */
	// struct stakeTokenTuple {
	// 	address stake;
	// 	address token;
	// }


	/*
	 *  Storage
	 */
	/// registrar registers for the two chains
	address private coreRegistrar;
	/// chainIdOrigin stores the chainId this chain
	uint256 private coreChainIdOrigin;
	/// chainIdRemote stores the chainId of the remote chain
	uint256 private coreChainIdRemote;
	/// DHashToken remote is the address of the DHashToken contract
	/// on the remote chain
	address private coreDHashTokenRemote;
	// /// 
	// mapping(bytes32 => address) stakeTokenTuple;


	/*
	 *  Public functions
	 */
	function Core(
		address _registrar,
		uint256 _chainIdOrigin,
		uint256 _chainIdRemote,
		address _DHashTokenRemote)
		public
	{
		require(_registrar != address(0));
		require(_chainIdOrigin != 0);
		require(_chainIdRemote != 0);
		require(_DHashTokenRemote != 0);
		coreRegistrar = _registrar;
		coreChainIdOrigin = _chainIdOrigin;
		coreChainIdRemote = _chainIdRemote;
		coreDHashTokenRemote = _DHashTokenRemote;
	}

	/*
	 *  Public view functions
	 */
	function registrar()
		public
		view
		returns (address /* registrar */)
	{
		return coreRegistrar;
	}

	function chainIdRemote()
		public
		view
		returns (uint256 /* chainIdRemote */)
	{
		return coreChainIdRemote;
	}

	function DHashTokenRemote()
		public
		view
		returns (address /* DHashTokenRemote */)
	{
		return coreDHashTokenRemote;
	}
}