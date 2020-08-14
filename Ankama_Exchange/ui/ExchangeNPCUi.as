package Ankama_Exchange.ui
{
    public class ExchangeNPCUi extends ExchangeUi 
    {


        override public function main(oParam:Object=null):void
        {
            input_kamaRight.selectable = false;
            super.main(oParam);
        }

        override protected function checkAcceptButton():void
        {
            if (((gd_left.dataProvider.length == 0) && (_leftPlayerKamaExchange == 0)))
            {
                btn_validate.disabled = true;
            }
            else
            {
                btn_validate.disabled = false;
            };
        }


    }
} Ankama_Exchange.ui

