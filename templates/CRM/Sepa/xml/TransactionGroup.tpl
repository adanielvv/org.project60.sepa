    <PmtInf>
      <PmtInfId>{$group.reference}</PmtInfId>
      <PmtMtd>DD</PmtMtd>
      <BtchBookg>false</BtchBookg>
      <NbOfTxs>{$nbtransactions}</NbOfTxs>
      <CtrlSum>{$total}</CtrlSum>
      <PmtTpInf>
        <SvcLvl>
          <Cd>SEPA</Cd>
        </SvcLvl>
        <LclInstrm>
{if $fileFormat == 'pain.008.003.02 COR1'}
          <Cd>COR1</Cd>
{else}
          <Cd>CORE</Cd>
{/if}
        </LclInstrm>
        <SeqTp>{$group.type}</SeqTp>
      </PmtTpInf>
      <ReqdColltnDt>{$group.collection_date|crmDate:"%Y-%m-%d"}</ReqdColltnDt>
      <Cdtr>
        <Nm>{$creditor.name}</Nm>
      </Cdtr>
      <CdtrAcct>
        <Id>
          <IBAN>{$creditor.iban}</IBAN>
        </Id>
      </CdtrAcct>
      <CdtrAgt>
        <FinInstnId>
          <BIC>{$creditor.bic}</BIC>
        </FinInstnId>
      </CdtrAgt>
      <ChrgBr>SLEV</ChrgBr>
      <CdtrSchmeId>
{if $fileFormat == 'pain.008.001.02'}{* legacy pain.008.001.02 format *}
        <Nm>{$creditor.name}</Nm>
{/if}
        <Id>
          <PrvtId>
            <Othr>
              <Id>{$creditor.identifier}</Id>
              <SchmeNm>
                <Prtry>SEPA</Prtry>
              </SchmeNm>
            </Othr>
          </PrvtId>
        </Id>
      </CdtrSchmeId>

{foreach from=$contributions item="contribution"}
      <DrctDbtTxInf>
        <PmtId>
          <EndToEndId>{$contribution.end2endID}</EndToEndId>
        </PmtId>
        <InstdAmt Ccy="{$contribution.currency}">{$contribution.total_amount}</InstdAmt>
        <DrctDbtTx>
          <MndtRltdInf>
            <MndtId>{$contribution.reference}</MndtId>
            <DtOfSgntr>{$contribution.validation_date|crmDate:"%Y-%m-%d"}</DtOfSgntr>
          </MndtRltdInf>
        </DrctDbtTx>
        <DbtrAgt>
{if $contribution.bic == ''}
          <FinInstnId />
{else}
          <FinInstnId>
            <BIC>{$contribution.bic}</BIC>
          </FinInstnId>
{/if}
        </DbtrAgt>
        <Dbtr>
          <Nm>{$contribution.display_name}</Nm>
        </Dbtr>
        <DbtrAcct>
          <Id>
            <IBAN>{$contribution.iban}</IBAN>
          </Id>
        </DbtrAcct>
        <RmtInf>
          <Ustrd>{$contribution.message}</Ustrd>
        </RmtInf>
      </DrctDbtTxInf>
{/foreach}

    </PmtInf>
