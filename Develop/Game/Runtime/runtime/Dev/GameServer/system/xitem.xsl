<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version = '1.0' xmlns:xsl = 'http://www.w3.org/1999/XSL/Transform'>
	<xsl:template match = "/">
		<html>	
			<head>
				<style type='text/css'>
					body {  font-family: verdana; font-size:11; color: #000000}
					td {  font-family: verdana; font-size:11; color: #000000}
				</style>
			</head>
			<body>
				<xsl:apply-templates select="maiet"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="maiet">
		<table bgcolor="black" cellspacing="1" cellpadding="1" >
			<tr>
				<td width="60"><font color="white">id</font></td>
				<td><font color="white"></font></td>
				<td><font color="white">Name</font></td>
				<td><font color="white">CD</font></td>
				<td><font color="white">Desc</font></td>
				<td><font color="white">Buy(cp)</font></td>
				<td><font color="white">Sell(cp)</font></td>
				<td><font color="white">QuestItem</font></td>
				<td><font color="white">Belonging</font></td>
				<td><font color="white">Tradable</font></td>
				<td><font color="white">Salability</font></td>
				<td><font color="white">Salability</font></td>
				<td><font color="white">Discardable</font></td>
				<td><font color="white">EnchantSlot</font></td>
				<td><font color="white">EnchantRate</font></td>
				<td><font color="white">EnchantLevel</font></td>
				<td width="30"><font color="white">EnchantRestriction</font></td>
			</tr>
			<xsl:apply-templates select="ITEM"/>
		</table>
	</xsl:template>
	
	<xsl:template match="ITEM">
		<tr bgcolor="white">
			<td>
				<xsl:value-of select="@id" />
			</td>
			<td align="center"><IMAGE src="../../{@icon}" width="40" height="40" /></td>
			<td>
				<xsl:choose>
					<xsl:when test="@tier = 'Rare'">
						<font color="#00bb00"><b><xsl:value-of select="@name" /></b></font>
					</xsl:when>
					<xsl:when test="@tier = 'Treasure'">
						<font color="0000ff"><b><xsl:value-of select="@name" /></b></font>
					</xsl:when>
					<xsl:when test="@tier = 'Legendary'">
						<font color="orange"><b><xsl:value-of select="@name" /></b></font>
					</xsl:when>
					<xsl:when test="@tier = 'Epic'">
						<font color="purple"><b><xsl:value-of select="@name" /></b></font>
					</xsl:when>
					<xsl:otherwise>
						<b><xsl:value-of select="@name" /></b>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:value-of select="@condition" />
			</td>
			<td>
				<xsl:value-of select="@desc" />
			</td>
			<td >
				<xsl:if test="string-length(@buying_price) > 0">
					<xsl:value-of select="format-number( @buying_price, '##,##,##' )" />
				</xsl:if>
			</td>
			<td >
				<xsl:if test="string-length(@selling_price) > 0">
					<xsl:value-of select="format-number( @selling_price, '##,##,##' )" />
				</xsl:if>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@quest_related = 'True'">
						<font color="brown"><b>Quest</b></font>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@claim_required = 'True'">
						<font color="blue"><b>Belonging</b></font>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@tradable = 'True'">
						<font color="blue"><b>Tradable</b></font>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@sellable = 'True'">
						<font color="red"><b>Sellable</b></font>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@discardable = 'True'">
						<font color="black"><b>Discardable</b></font>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:value-of select="@stack_amount" />
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="starts-with( @EquipEnchantSlot, 'X' )">
						<xsl:value-of select="@EquipEnchantSlot" />
					</xsl:when>
					<xsl:otherwise>
						<B><font color="red"><xsl:value-of select="@EquipEnchantSlot" /></font></B>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:if test="string-length(@EnchantRate) > 0">
					<xsl:value-of select="@EnchantRate" /> %
				</xsl:if>
			</td>
			<td>
				<xsl:value-of select="@EnchantLimitLevel" />
			</td>
			<td>
				<xsl:value-of select="translate( @EnchantLimitEquipments, ',', ' ' ) " />
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>