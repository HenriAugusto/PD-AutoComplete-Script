;this class represents an Pure Data object or abstraction
class ObjectAbstraction{
    boxName := 
    library := 

    __New(n, l){
        this.boxName := n
        this.library := l

    }

    debugBox(){
        boxName := this.boxName ;why is "this." needed?
        library := this.library ;why is "this." needed?
        MsgBox, , Debugging %boxName%, name = %boxName%`nlibrary = %library%
    }
}