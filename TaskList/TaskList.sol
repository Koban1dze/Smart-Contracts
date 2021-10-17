pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TaskList {

    struct list {
        string  name;
        uint32  timestamp; 
        bool flag;
    }
           mapping (int8=>list) key;
    int8 i = 0;
    int8 openTasks=0;
    

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

       modifier checkOwnerAndAccept{
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function addTask(string valueName) public checkOwnerAndAccept {
        key[i].name =valueName;
        key[i].timestamp=now;
        key[i].flag=false;
        i++;
        openTasks++;
    }
    function getTask(int8 valueKey) public checkOwnerAndAccept returns(string,uint32,bool) {
        return(key[valueKey].name,key[valueKey].timestamp,key[valueKey].flag);
    }
    function getAllTask() public checkOwnerAndAccept returns(mapping (int8 =>list))
    {
         return(key);
    }
    
    function openTask() public checkOwnerAndAccept returns(int8)
    {
        return(openTasks);
    }
    function flagChange(int8 valueKey) public checkOwnerAndAccept {
        key[valueKey].flag = true;
        openTasks --;
    }
    function removeTask(int8 valueKey) public checkOwnerAndAccept {
        delete key[valueKey];
      

    }
}
