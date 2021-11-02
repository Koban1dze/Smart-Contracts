pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "Game_Interface.sol";


contract Game_Object is Game_Interface {
    
    uint healthBar;
    uint armor;
    address public attackerAddress;
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    function getArmor() public virtual returns(uint) {
        tvm.accept();
        return armor;
    }
    function takeAttack(uint damage) external override {
        tvm.accept();
        attackerAddress = msg.sender;
        armor=armor-damage;
    }
    function checkForDeath() private returns(bool) {
        tvm.accept();
        if (armor <= 0) {
            return true;
        }
    }
    function destroy() public virtual {
        suicideD();
    } 
    function suicideD() private {
        tvm.accept();
        attackerAddress.transfer(322,true,160);
    }
        function addUnit(address unitAddress) external virtual{}
        function deleteUnit(address unitAddress) external virtual{}
   

}