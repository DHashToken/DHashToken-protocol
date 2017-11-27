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
// Utility chain: UtilityTokenAbstract
//
// http://www.simpletoken.org/
//
// ----------------------------------------------------------------------------

import "./SafeMath.sol";
import "./ProtocolVersioned.sol";

// utility chain contracts
import "./UtilityTokenInterface.sol";

/// @title UtilityToken abstract
contract UtilityTokenAbstract is ProtocolVersioned, UtilityTokenInterface {
	using SafeMath for uint256;

	/*
	 *  Events
	 */
	/// Minted raised when new utility tokens are minted for a beneficiary
	/// Minted utility tokens still need to be claimed by anyone to transfer
	/// them to the beneficiary.
    event Minted(bytes32 indexed _uuid, address indexed _beneficiary,
    	uint256 _amount, uint256 _unclaimed, uint256 _totalSupply);
    event Burnt(bytes32 indexed _uuid, address indexed _account,
    	uint256 _amount, uint256 _totalSupply);
	
    /*
     *  Storage
     */
	/// UUID for the utility token
	bytes32 public uuid;
	/// totalSupply holds the total supply of utility tokens
	uint256 private totalTokenSupply;
	/// claims is follows EIP20 allowance pattern but
	/// for a staker to stake the utility token for a beneficiary
	mapping(address => uint256) private claims;

    /*
     * Public functions
     */
    function UtilityTokenAbstract(address _protocol, bytes32 _uuid)
    	public
    	ProtocolVersioned(_protocol)
    {
    	uuid = _uuid;
    	totalTokenSupply = 0;
    }

	// /// @dev transfer full claim to beneficiary
 //    function claim(address _beneficiary) public returns (bool success);
 //    /// @dev Mint new utility token into 
 //    function mint(address _beneficiary, uint256 _amount) public returns (bool success);
 //    /// @dev Burn utility tokens after having redeemed them
 //    ///      through the protocol for the staked Simple Token
 //    function burn(address _burner, uint256 _amount) public payable returns (bool success);
   	
 	/// @dev Get totalTokenSupply as view so that child cannot edit
	function totalSupply()
		public
		view
		returns (uint256 /* supply */)
	{
		return totalTokenSupply;
	}

    /// @dev returns unclaimed amount for beneficiary
	function unclaimed(
		address _beneficiary)
		public
		view
		returns (uint256 /* amount */)
	{
		return claims[_beneficiary];
	}

    /*
     * Internal functions
     */
 	/// @dev claim transfers all utility tokens to _beneficiary
 	function claimInternal(
    	address _beneficiary)
    	internal
    	returns (uint256 amount)
    {
    	amount = claims[_beneficiary];
    	claims[_beneficiary] = 0;

    	return amount;
    }

    /// @dev Mint new utility token by adding a claim
    ///      for the beneficiary
    function mintInternal(
    	address _beneficiary,
    	uint256 _amount)
    	internal
    	returns (bool /* success */)
    {
    	totalTokenSupply = totalTokenSupply.add(_amount);
        claims[_beneficiary] = claims[_beneficiary].add(_amount);

		Minted(uuid, _beneficiary, _amount, claims[_beneficiary], totalTokenSupply);

		return true;    	
    }

    /// @dev Burn utility tokens after having redeemed them
    ///      through the protocol for the staked Simple Token
    function burnInternal(
    	address _burner,
    	uint256 _amount)
    	internal
    	returns (bool /* success */)
	{
		totalTokenSupply = totalTokenSupply.sub(_amount);

		Burnt(uuid, _burner, _amount, totalTokenSupply);

		return true;
	}
}