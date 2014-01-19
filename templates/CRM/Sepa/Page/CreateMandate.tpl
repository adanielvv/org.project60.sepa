{literal}
<style>
.create_mandate td {
	white-space: nowrap;
	min-width: 20em;
	vertical-align: middle;
}
</style>
{/literal}


{if $submit_url}
<form id='new_sepa_mandate' action="{$submit_url}" method="post">
	<input type="hidden" name="contact_id" value="{$contact_id}" />
	<table>
		<tr>	<!-- CREDITOR -->
			<td>{ts}Creditor{/ts}:</td>
			<td>
				<select disabled name="creditor_id">
					{foreach from=$creditors item=name key=id}
					<option value="{$id}">{$name}</option>
					{/foreach}
				</select>
			</td>
		</tr>
		<tr>	<!-- CONTACT -->
			<td>{ts}Contact{/ts}:</td>
			<td><input disabled name="contact" type="text" size="40" value="{$display_name}"/></td>
		</tr>
		<tr>	<!-- AMOUNT -->
			<td>{ts}Amount{/ts}:</td>
			<td><input name="total_amount" type="number" size="6"/>&nbsp;EUR</td>
		</tr>
		<tr>	<!-- FINANCIAL TYPE -->
			<td>{ts}Financial Type{/ts}:</td>
			<td>
				<select name="financial_type_id">
					{foreach from=$financial_types item=name key=id}
					<option value="{$id}">{$name}</option>
					{/foreach}
				</select>
			</td>
		</tr>
		<tr>	<!-- CAMPAIGN -->
			<td>{ts}Campaign{/ts}:</td>
			<td>
				<select name="campaign_id">
					{foreach from=$campaigns item=name key=id}
					<option value="{$id}">{$name}</option>
					{/foreach}
				</select>
			</td>
		</tr>
		<tr>	<!-- SOURCE -->
			<td>{ts}Source{/ts}:</td>
			<td><input name="source" type="text" value="Telefon"/></td>
		</tr>
		<tr>	<!-- NOTE -->
			<td id="mandate_note_label">{ts}Note{/ts}:</td>
			<td><input name="note" type="text" size="32" value=""/></td>
		</tr>

		<tr><td colspan="4"><hr></td></tr>

		<tr>	<!-- bank account selector -->
			<td>Bank Account:</td>
			<td>
				<select name="account" id="account">
				{foreach from=$known_accounts item=account}
				<option value="{$account.value}">{$account.name}</option>
				{/foreach}
				</select>
			</td>
			<td id="iban_converter" rowspan="3" style="vertical-align: middle;">
			</td>
		</tr>
		<tr>	<!-- IBAN -->
			<td>IBAN:</td>
			<td><input name="iban" type="text" size="32" value="{$iban}"/></td>
		</tr>
		<tr>	<!-- BIC -->
			<td>BIC:</td>
			<td><input name="bic" type="text" size="13" value="{$bic}"/></td>
		</tr>
	</table>

	<h3>{ts}Mandate Type{/ts}</h3>
	<table class="create_mandate">
		<tr>	<!-- ONE OFF -->
			<td style="vertical-align: top;"><input name="mandate_type" type='radio' value="OOFF" checked>{ts}One Time{/ts}</input></td>
			<td>{ts}Earliest execution date{/ts}:</td>
			<td><input name="date" type="date" value="{$today}" size="10" /></td>
			<td></td>
		</tr>

		<tr><td colspan="3"><div>&nbsp;</div></td></tr>

		<tr>	<!-- RECURRING -->
			<td style="vertical-align: top;" rowspan="4"><input disabled name="mandate_type" type='radio' value="RCUR">{ts}Recurring{/ts}</input></td>
			<td>{ts}Start Date{/ts}:</td>
			<td><input name="start_date" type="date" value="{$today}" size="10" /></td>
			<td></td>
		</tr>
		<tr>
			<td>{ts}Cycle Day{/ts}:</td>
			<td><input name="cycle_day" type="number" value="1" size="3" /></td>
			<td></td>
		</tr>
		<tr>
			<td>{ts}Interval{/ts}:</td>
			<td><input name="interval" type="number" value="1" size="3" /></td>
			<td></td>
		</tr>
		<tr>
			<td>{ts}End Date{/ts}:</td>
			<td><input name="start_date" type="date" value="{$today}" size="10" /></td>
			<td></td>
		</tr>
	</table>
	<input type="submit" value="{ts}create{/ts}" />
</form>

{else}
	{if $error_message}
		<h2>{ts}Error!{/ts} {$error_title}</h2>
		<p>{$error_message}</p>
	{else}
		<h2>{ts}Mandate successfully created.{/ts}<br/>
		{ts}Reference is{/ts}: {$reference}</h2>
	{/if}
	<br/><br/>
	<a href="{$back_url}" class="back button" title="{ts}back{/ts}">
    	<span>
    		<div class="icon back-icon"></div>
    		{ts}view{/ts}
    	</span>
    </a>
{/if}


{literal}
<script type="text/javascript">
// logic for the bank account selector
cj("#account").change(function() {
	var values = cj("#account").val().split("/");
	cj("[name='iban']").val(values[0]);
	cj("[name='bic']").val(values[1]);
});
</script>
{/literal}

