//��������������������������������������������������������Ŀ
//� 10/04/2007                                             �
//� Bops 123498:                                           �
//� Esta funcao foi renomeada de PWSC052 para PWSC052B para�
//� evitar erro de duplicidade de funcao no repositorio.   �
//����������������������������������������������������������
User Function PWSC052B()

Local aReturn := {}

//�������������������������������������������������������������������������Ŀ
//� Campos a serem mostrados             									�
//���������������������������������������������������������������������������
aAdd( aReturn, "ORDERID" )
aAdd( aReturn, "ORDERTYPECODE" )
aAdd( aReturn, "CARRIERCODE" )
aAdd( aReturn, "FINANCIALDISCOUNT" )
aAdd( aReturn, "REGISTERDATE" )
aAdd( aReturn, "BIDNUMBER" )
aAdd( aReturn, "FREIGHTTYPE" )
aAdd( aReturn, "FREIGHTVALUE" )
aAdd( aReturn, "INSURANCEVALUE" )
aAdd( aReturn, "ADDITIONALEXPENSEVALUE" )

Return aReturn