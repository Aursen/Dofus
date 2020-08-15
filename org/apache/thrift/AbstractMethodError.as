package org.apache.thrift
{
    import flash.errors.IllegalOperationError;

    public class AbstractMethodError extends IllegalOperationError 
    {

        public function AbstractMethodError(_arg_1:String="")
        {
            super("Attempt to call an abstract method");
        }

    }
}

