pragma solidity ^0.8.4;
//SPDX-License-Identifier: MIT
//BUTTPOOP was created in the stalls
//Goal is to BOWL
//and to get someone on TV to say "BUTTPOOP?"
//and to DESTROY FIAT
//and to ensure the safety of sanitary systems 
//so that we all become
//STALLMASTERS
//BUTTPOOP.COM

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
//import 'https://github.com/niguezrandomityengine/ethereumAPI/blob/master/nreAPI.sol';

interface niguezRandomityEngine {
    function ra() external view returns (uint256);
        }

contract BUTTPOOP is ERC20 {

    uint FLUSH_FEE = 69;
    uint LOTTERY_FEE = 420;
    uint counter = 0;
    address public owner;

    //mapping of all holders 
    mapping(address => bool) public holders; //people's balances
    mapping(uint => address) public indexes;
    uint public topindex;
    
    
niguezRandomityEngine internal nre = niguezRandomityEngine(0x031eaE8a8105217ab64359D4361022d0947f4572);

    
constructor() ERC20 ('BUTTPOOP','BTPP') {
    _mint(msg.sender, 91166642069* 10 ** 18);
    owner = msg.sender;
    holders[msg.sender] = true;
    indexes[topindex] = msg.sender;
    topindex += 1;


    }
    
function transfer(address recipient, uint256 amount) public override returns (bool){

            
            uint burnAmount = amount*(FLUSH_FEE) / 10000;
            uint lotteryAmount = amount*(LOTTERY_FEE) / 10000;
            _transfer(_msgSender(), address(this), lotteryAmount);
            _burn(_msgSender(), burnAmount);
            _transfer(_msgSender(), recipient, amount-(burnAmount)-(lotteryAmount));
        
     
      
      if (!holders[recipient]) 
        {
            holders[recipient] = true;
            indexes[topindex] = recipient;
            topindex += 1;
        }
        
        counter += 1;
        if (counter == 10) 
        {
        counter = 0;
        address payable winner = payable (indexes[nre.ra() % topindex]);
        _transfer(address(this), winner, balanceOf(address(this)));
        }
      
      return true;
    }    


function ra() internal view returns (uint256) {
        return nre.ra() % 10;
    } 
 
}
 
