<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
	xmlns = "http://ltsc.ieee.org/xsd/LOM"
	xmlns:md = "http://www.imsglobal.org/xsd/imsmd_v1p2"
	xmlns:lom = "http://ltsc.ieee.org/xsd/LOM"
	xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="md lom">
	
	<xsl:output method = "xml" encoding="utf-8" indent="yes"/> 
	
	<!-- ***********************************************************************************-->
	<!--                                                                                    -->
	<!-- Author:    Colin Smythe                                                            -->
	<!-- Version:   1.0                                                                     -->
	<!-- Date:      31st August, 2006                                                     	-->
	<!-- Comments:  This XSL transforms instances of IMS Metadata, version 1.2.4, into		-->
	<!--            instances of IEEE LOM, version 1.0.	The converted files are placed in	-->
	<!--            the same directory as the source instance.   	                        -->
	<!--                                                                                    -->
	<!-- Templates: The TEMPLATES declared in this  file are:                               -->
	<!--            (1) 'catalogAndIdentifier'												-->
	<!--            (2) 'catalogentry'											            -->
	<!--            (3) 'datetimeConversion'												-->
	<!--            (4) 'durationConversion'												-->
	<!--            (5) 'durationConversionUtil'											-->
	<!--            (6) 'md:*'																-->
	<!--            (7) 'md:aggregationlevel'												-->
	<!--            (8) 'md:annotation'														-->
	<!--            (9) 'md:catalogentry'													-->
	<!--            (10) 'md:centity'														-->
	<!--            (11) 'md:classification'												-->
	<!--            (12) 'md:context'														-->
	<!--            (13) 'md:copyrightandotherrestrictions'									-->
	<!--            (14) 'md:cost'															-->
	<!--            (15) 'md:datetime'														-->
	<!--            (16) 'md:datetime(duration)'											-->
	<!--            (17) 'md:description'													-->
	<!--            (18) 'md:difficulty'													-->
	<!--            (19) 'md:duration'														-->
	<!--            (20) 'md:educational'													-->
	<!--            (21) 'md:entry'															-->
	<!--            (22) 'md:general'														-->
	<!--            (23) 'md:identifier'													-->
	<!--            (24) 'md:installationremarks'											-->
	<!--            (25) 'md:intendedenduserrole'											-->
	<!--            (26) 'md:interactivitylevel'											-->
	<!--            (27) 'md:interactivitytype'												-->
	<!--            (28) 'md:kind'															-->
	<!--            (29) 'md:langstring'													-->
	<!--            (30) 'md:learningresourcetype'											-->
	<!--            (31) 'md:lifecycle'														-->
	<!--            (32) 'md:lom'															-->
	<!--            (33) 'md:maximumversion'												-->
	<!--            (34) 'md:metadataschema'												-->
	<!--            (35) 'md:metametadata'													-->
	<!--            (36) 'md:minimumversion'												-->
	<!--            (37) 'md:name'															-->
	<!--            (38) 'md:otherplatformrequirements'										-->
	<!--            (39) 'md:person'														-->
	<!--            (40) 'md:purpose'														-->
	<!--            (41) 'md:relation'														-->
	<!--            (42) 'md:resource'														-->
	<!--            (43) 'md:rights'														-->
	<!--            (44) 'md:role'															-->
	<!--            (45) 'md:semanticdensity'												-->
	<!--            (46) 'md:source(taxonpath)'												-->
	<!--            (47) 'md:source(nonLOM)'												-->
	<!--            (48) 'md:source'														-->
	<!--            (49) 'md:taxon(taxonpath)'												-->
	<!--            (50) 'md:technical'														-->
	<!--            (51) 'md:type'															-->
	<!--            (52) 'md:typcalagerange'												-->
	<!--            (53) 'md:typicallearningtime'											-->
	<!--            (54) 'md:value(nonLOM)'													-->
	<!--            (55) 'md:value'															-->
	<!--            (56) 'orComposite'														-->
	<!--            (57) 'orCompositeBody'													-->
	<!--            (58) 'requirement'														-->
	<!--            (59) 'requirementList'													-->
	<!--            (60) 'translateToken'													-->
	<!--            (61) 'translateWord'													-->
	<!--            (62) 'vocabularyOther'													-->
	<!--            (63) 'wildcard'															-->
	<!--                                                                                    -->
	<!-- Processor: This transform uses standard XSL v1.0.  No extensions are used.         -->
	<!--                                                                                    -->
	<!-- History:   Draft v1.0 of the IMS Metadata version 1.2.4 to IEEE LOM version 1.0	-->
	<!--            transform was produced by Brendon Towle, Thomson NETg, on 16 September	-->
	<!--            2003.  It was based upon Thomas Dooley's LOM binding.					-->
	<!--                                                                                    -->
	<!-- Copyright: 2006 (c) IMS Global Learning Consortium Inc.  All Rights Reserved.      -->
	<!-- IMS Global Learning Consortium, Inc. (IMS/GLC) is publishing the information 		-->
	<!-- contained in this binding (“Specification”) for purposes of scientific,      		-->
	<!-- experimental and scholarly collaboration only.  IMS/GLC makes no warranty or    	-->
	<!-- representation regarding the accuracy or completeness of the Specification.  This	-->
	<!-- material is provided on an “As Is” and “As Available” basis.  The Specification is	-->
	<!-- at all times subject to change and revision without notice.  It is your sole		-->
	<!-- responsibility to evaluate the usefulness, accuracy and completeness of the		-->
	<!-- Specification as it relates to you.  IMS/GLC would appreciate receiving your		-->
	<!-- comments and suggestions.  Please contact IMS/GLC through our website at:			-->
	<!-- http://www.imsglobal.org.															-->
	<!--                                                                                    -->
	<!--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-->

	<!-- Global Variables ****************************************************************  -->
	
	<xsl:variable name = "metaDataSchemaHandling" select = "'fixed'"/>												<!-- ##MetaDataSchema -->
	
	<!-- <xsl:variable name = "metaDataSchemaHandling" select = "'copy'"/>	-->
	
	<xsl:variable name = "unknownSource" select = "'unknown'"/>														<!-- ##UnknownSource -->
	
	<xsl:variable name = "imsmdNamespacev1p2p4" select = "'http://www.imsglobal.org/xsd/imsmd_v1p2'"/>				<!-- ##Namespace for the IMS Metadata v1p2p1 -->

	<!-- ==================================================================================  -->
	
	<!-- Top Level Template *************************************************************** -->
	
	<xsl:template match = "md:lom">
		
		<!-- Parsing original xsi:schemaLocation attribute and remove unnecessary schemas -->	
		<xsl:variable name="schema">
				<xsl:if test="@xsi:schemaLocation">
					<xsl:call-template name="schemaMetadataLocationParsing">
							<xsl:with-param name="original" select="normalize-space(@xsi:schemaLocation)" />
					</xsl:call-template>
				</xsl:if>
		</xsl:variable>
	
	       <!-- If neede adding http://www.imsglobal.org/xsd/imscp_v1p1 schema location  -->	
	       <xsl:variable name="schemaLocation">
			<xsl:value-of select="concat($schema,' http://ltsc.ieee.org/xsd/LOM lomLoose.xsd ')"/>	
	       </xsl:variable>	


		<lom xmlns = "http://ltsc.ieee.org/xsd/LOM"
			xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="{$schemaLocation}" 	>  
			<xsl:apply-templates select = "*"/>
		</lom>
		
	</xsl:template>  
	
	<!-- ==================================================================================  -->

	<!-- Generic Templates **************************************************************** -->

	<!-- The following templates are to handle extensions. Their job is simply to recognize elements that
	     aren't in the IMS namespace, and copy them unchanged to the target document.
	     
	     It is called by name in places where the structure of the XSL prevents a generic apply-templates,
	     and referenced through the generic mechanism where possible. -->
	
	<!--
	     <xsl:template match = "*">
		<xsl:if test = "namespace-uri() != $imsmdNamespacev1p2p4">
			<xsl:copy-of select = "."/>
		</xsl:if>
		
	</xsl:template>
  -->
	<!-- ==================================================================================  -->
	
	<!-- This template copies comments from the source document to the target document. ***  -->

	

	<!-- ==================================================================================  -->

	<!-- This is the default template that does most of the work. It gets called when there is
	     no more specific template available. The logic is: 
	     Copy the element and all attributes from the IMS namespace,
	     and put them in the target document, in the same order with the same names, but in the
	     IEEE namespace. If the element has attributes that are not from the IMS namespace, copy
	     them to the target element, leaving the namespace unchanged. If the node has text children,
	     copy them to the target element as well. 
	     
	     Note the special-case structure to handle (i.e., remove) the 'type' attribute from the
	     IMS binding.  -->

	<xsl:template match = "md:*">
		
		<xsl:variable name = "name" select = "local-name()"/>
		<xsl:element name = "{local-name()}">
			<xsl:for-each select ="@*">
				<xsl:choose>
					<xsl:when test = "local-name() = 'type'"/>
					<xsl:when test = "namespace-uri() != 'http://www.imsglobal.org/xsd/imsmd_rootv1p2p1'">
						<xsl:attribute name = "{local-name()}" namespace = "{namespace-uri()}">
							<xsl:value-of select = "."/>
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name = "{local-name()}"><xsl:value-of select = "."/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each select = "text()">
				<xsl:value-of select = "."/>
			</xsl:for-each>
			<xsl:apply-templates select = "*"/>
			<xsl:apply-templates select = "comment()"/>
		</xsl:element>
		<xsl:for-each select ="@*">
			<xsl:if test = "local-name() = 'type'">
				<xsl:comment>The following information was removed from a 'type' attribute:</xsl:comment>
				<xsl:comment><xsl:value-of select = "."/></xsl:comment>
			</xsl:if>
		</xsl:for-each>
		
	</xsl:template>

	<!-- ==================================================================================  -->

	<!-- General Template and Children **************************************************** -->

	<xsl:template match = "md:general">
		
		<general>
			
			<xsl:comment>General Section</xsl:comment>
			<xsl:call-template name = "catalogAndIdentifier"/>
			<xsl:apply-templates select = "md:title"/>
			<xsl:apply-templates select = "md:language"/>
			<xsl:apply-templates select = "md:description"/>
			<xsl:apply-templates select = "md:keyword"/>
			<xsl:apply-templates select = "md:coverage"/>
			<xsl:apply-templates select = "md:structure"/>
			<xsl:apply-templates select = "md:aggregationlevel"/>
			<xsl:call-template name = "wildcard"/>
			
		</general>
		
	</xsl:template>

	<xsl:template match = "md:aggregationlevel">
		
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'aggregationLevel'"/>
			<xsl:with-param name = "alternateName" select = "'aggregationLevelOther'"/>
		</xsl:call-template>
		
	</xsl:template>


	<!-- ##CatologEntry -->
	<!-- The logic of this is as follows. If there is an identifier element, create a catalogentry in
	     the target, where the entry is the value of the identifier element and the catalog is blank.
	     Any catalogentry elements get copied into comments. If there is no identifier element,
	     copy catalogentry elements as is. -->
	     
	<xsl:template name = "catalogAndIdentifier">
		<xsl:choose>
			<xsl:when test = "md:identifier">
				<xsl:for-each select = "md:identifier">
					<identifier>
						<catalog/>
						<entry><xsl:value-of select = "."/></entry>
						<xsl:call-template name = "wildcard"/>
					</identifier>
				</xsl:for-each>
				<xsl:if test = "md:catalogentry">
					<xsl:comment>The following CATALOGENTRY elements were removed from the original source:</xsl:comment>
					<xsl:for-each select = "md:catalogentry">
						<xsl:comment>Catalog: <xsl:value-of select = "md:catalog"/>, Entry: <xsl:value-of select = "md:entry/md:langstring"/>
						</xsl:comment>
					</xsl:for-each>
				</xsl:if>
			</xsl:when>
			<xsl:when test = "md:catalogentry">
				<xsl:for-each select = "md:catalogentry">
					<xsl:call-template name = "catalogentry"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>

	<xsl:template match = "md:entry">
		<entry>
			<xsl:value-of select = "md:langstring"/>
		</entry>
	</xsl:template>
	
	<!-- Note that the following template is _named_ 'catalogentry'; it does not automatically
	     match 'md:catalogentry' elements. -->
	
	<xsl:template name = "catalogentry">
		<identifier>
			<xsl:apply-templates select = "*"/>
			<xsl:call-template name = "wildcard"/>
		</identifier>
	</xsl:template>

	<!-- These are here to block the IDENTIFIER and CATALOGENTRY elements from being picked up
	     by the standard wildcard template. -->
	
	<xsl:template match = "md:identifier"/>
	<xsl:template match = "md:catalogentry"/>
	
	<!-- ==================================================================================  -->
	     
	<!-- Lifecycle Template and Children ************************************************** -->

	<xsl:template match = "md:lifecycle">    
		<lifeCycle>
			<xsl:comment>Lifecycle Section</xsl:comment>
			<xsl:apply-templates select = "*"/>
		</lifeCycle>
	</xsl:template>

	<xsl:template match = "md:centity">
		<entity>
			<xsl:value-of select = "md:vcard"/>
		</entity>
	</xsl:template>

	<xsl:template match = "md:role">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'role'"/>
			<xsl:with-param name = "alternateName" select = "'role'"/>
		</xsl:call-template>
	</xsl:template>

	<!-- ==================================================================================  -->

	<!-- Metametadata Template and Children  ********************************************** -->
	
	<xsl:template match = "md:metametadata">
		<xsl:choose>
			<xsl:when test = "$metaDataSchemaHandling = 'fixed'">
				<metaMetadata>
					<xsl:comment>Metametadata Section</xsl:comment>
					<xsl:call-template name = "catalogAndIdentifier"/>
					<xsl:apply-templates select = "md:contribute"/>
					<metadataSchema>IEEE LOM 1.0</metadataSchema>
					<xsl:apply-templates select = "md:language"/>
					<xsl:call-template name = "wildcard"/>
				</metaMetadata>
			</xsl:when>
			<xsl:when test = "$metaDataSchemaHandling = 'copy'">
				<metaMetadata>
					<xsl:comment>Metametadata Section</xsl:comment>
					<xsl:call-template name = "catalogAndIdentifier"/>
					<xsl:apply-templates select = "md:contribute"/>
					<xsl:apply-templates select = "md:metadatascheme"/>
					<xsl:apply-templates select = "md:language"/>
					<xsl:call-template name = "wildcard"/>
				</metaMetadata>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match = "md:metadatascheme">    
		<metaDataSchema>
			<xsl:value-of select = "."/>   
		</metaDataSchema>
	</xsl:template>  

	<!-- ==================================================================================  -->

	<!-- Technical Template and Children ************************************************** -->

	<xsl:template match = "md:technical">
		
		<technical>
			
			<xsl:comment>Technical Section</xsl:comment>
			<xsl:apply-templates select = "md:format"/>
			<xsl:apply-templates select = "md:size"/>
			<xsl:apply-templates select = "md:location"/>
			<xsl:call-template name = "requirement"/>
			<xsl:apply-templates select = "md:installationremarks"/>
			<xsl:apply-templates select = "md:otherplatformrequirements"/>
			<xsl:apply-templates select = "md:duration"/>
			
			<xsl:call-template name = "wildcard"/>

		</technical>
		
	</xsl:template>  

	<xsl:template match = "md:installationremarks">
		<installationRemarks>
			<xsl:apply-templates select = "*"/>
		</installationRemarks>
	</xsl:template>

	<xsl:template match = "md:otherplatformrequirements">
		<otherPlatformRequirements>
			<xsl:apply-templates select = "*"/>
		</otherPlatformRequirements>
	</xsl:template>

	<xsl:template match = "md:duration">
		<duration>
			<xsl:apply-templates select = "*" mode = "duration"/>
		</duration>
	</xsl:template>


<!-- Note that there are two versions of the 'requirement' template; one that is commented out that
     makes no assumptions about the semantics of repeated requirements, and one that is active
     that does make assumptions about the semantics of repeated requirements.
     
     If you want the version that does not make any assumptions, switch the commenting. Note that
     this version of the 'orComposite' template contains an embedded comment, and that nested
     comments confuse most XML parsers, so you will have to remove the embedded comment (or remove
     the comment delimiters).-->
     
<!-- ##Requirement -->

<!--

The following four templates (requirement, requirementList, orComposite, and orCompositeBody) are
designed around the assumption that if an instance of metadata has repeated requirements of the
same type (for instance, Browser), that those repeated requirements form an OR relationship. So,
these templates group those requirements from the source into a single requirement in the target,
using the <orComposite> structure in LOM. If this is not the behavior you want, comment these
templates out, and uncomment the requirements group below, which just translates requirements
into a single requirement.

The algorithm is patterned after the example on pages 622-624 of "XSLT 2nd Edition: Programmer's
Reference", by Michael Kay, published by Wrox Press, ISBN 1-861005-06-7.

-->

	<xsl:template name = "requirement">
		<xsl:variable name = "reqs"
		              select = "md:requirement[not(md:type/md:value/md:langstring =
		                                           preceding-sibling::md:requirement/md:type/md:value/md:langstring)]
		                        /md:type/md:value/md:langstring"/>
		<xsl:call-template name = "requirementList">
			<xsl:with-param name = "list" select = "$reqs"/>
		</xsl:call-template>
		<xsl:variable name = "nullReqs"
		              select = "md:requirement[not(md:type/md:value/md:langstring)]"/>
		<xsl:for-each select = "$nullReqs">
			<requirement>
				<xsl:call-template name = "orComposite">
					<xsl:with-param name = "null" select = "'true'"/>
				</xsl:call-template>
			</requirement>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name = "requirementList">
		<xsl:param name = "list"/>
		<xsl:for-each select = "$list">
			<requirement>
				<xsl:for-each select = "//md:requirement[md:type/md:value/md:langstring = current()]">
					<xsl:call-template name = "orComposite"/>
				</xsl:for-each>
			</requirement>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name = "orComposite">	
		<xsl:param name = "null"/>
		<xsl:variable name = "type" select = "md:type/md:value/md:langstring"/>
		<xsl:variable name = "source" select = "md:type/md:source/md:langstring"/>
		<orComposite>
			<xsl:choose>
				<xsl:when test = "$null = 'true'">
					<xsl:call-template name = "orCompositeBody"/>
				</xsl:when>
				<xsl:when test = "$type = 'Browser'">
					<xsl:call-template name = "orCompositeBody">
						<xsl:with-param name = "nameName" select = "'name'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test = "$type = 'Operating System'">
					<xsl:call-template name = "orCompositeBody">
						<xsl:with-param name = "nameName" select = "'name'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test = "$source != 'LOMv1.0'">
					<xsl:call-template name = "orCompositeBody">
						<xsl:with-param name = "nameName" select = "'name'"/>
						<xsl:with-param name = "typeName" select = "'type'"/>
						<xsl:with-param name = "source" select = "$source"/>
					</xsl:call-template>
				</xsl:when>
				
				<!-- If we get here, there's something wrong with the source metadata. First, check to see
				     if the source metadata is incorrectly claiming a vocabulary source of 'LOMv1.0', and
				     change the source to 'unknown' if that's true.  -->
				
				<xsl:when test = "$source = 'LOMv1.0'">
					<xsl:comment> Note that the following requirement has been changed. It originally claimed an </xsl:comment>
					<xsl:comment> incorrect source of 'LOMv1.0'; that has been changed to 'unknown'. </xsl:comment>
					<xsl:call-template name = "orCompositeBody">
						<xsl:with-param name = "nameName" select = "'name'"/>
						<xsl:with-param name = "typeName" select = "'type'"/>
						<xsl:with-param name = "source" select = "$unknownSource"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</orComposite>
	</xsl:template>
	
	<xsl:template name = "orCompositeBody">
		<xsl:param name = "nameName" select = "'name'"/>
		<xsl:param name = "typeName" select = "'type'"/>
		<xsl:param name = "source" select = "'LOMv1.0'"/>
		<xsl:apply-templates select = "*">
			<xsl:with-param name = "typeName" select = "$typeName"/>
			<xsl:with-param name = "nameName" select = "$nameName"/>
			<xsl:with-param name = "source" select = "$source"/>
		</xsl:apply-templates>
	</xsl:template>
	
	
<!-- 
The commented out templates below ('requirement' and 'orComposite') simply translate requirements
into the new format; they do not make any assumptions about the semantics of repeated types. If
this is the behavior you want, uncomment these templates, and comment out the 'requirement',
'requirementList', 'orComposite', and 'orCompositeBody' templates above.
-->

<!-- 

	<xsl:template name = "requirement">
		<xsl:for-each select = "md:requirement">
			<xsl:variable name = "type" select = "md:type/md:value/md:langstring"/>
			<xsl:variable name = "source" select = "md:type/md:source/md:langstring"/>
			<requirement>
				<orComposite>
					<xsl:choose>
						<xsl:when test = "$type = 'Browser'">
							<xsl:call-template name = "orComposite">
								<xsl:with-param name = "nameName" select = "'name'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test = "$type = 'Operating System'">
							<xsl:call-template name = "orComposite">
								<xsl:with-param name = "nameName" select = "'name'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test = "$source != 'LOMv1.0'">
							<xsl:call-template name = "orComposite">
								<xsl:with-param name = "nameName" select = "'name'"/>
								<xsl:with-param name = "typeName" select = "'type'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test = "$source = 'LOMv1.0'">
							<xsl:comment> Note that the following requirement has been changed. It originally claimed an </xsl:comment>
							<xsl:comment> incorrect source of 'LOMv1.0'; that has been changed to 'unknown'. </xsl:comment>
							<xsl:call-template name = "orCompositeBody">
								<xsl:with-param name = "nameName" select = "'name'"/>
								<xsl:with-param name = "typeName" select = "'type'"/>
								<xsl:with-param name = "source" select = "$unknownSource"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</orComposite>
				<xsl:call-template name = "wildcard"/>
			</requirement>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name = "orComposite">
		<xsl:param name = "nameName" select = "'name'"/>
		<xsl:param name = "typeName" select = "'type'"/>
		<xsl:apply-templates select = "md:type">
			<xsl:with-param name = "typeName" select = "$typeName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select = "md:name">
			<xsl:with-param name = "nameName" select = "$nameName"/>
		</xsl:apply-templates>
		<xsl:apply-templates select = "md:minimumversion"/>
		<xsl:apply-templates select = "md:maximumversion"/>
	</xsl:template>
		
	-->


	<xsl:template match = "md:type">
		<xsl:param name = "typeName" select = "'type'"/>
		<xsl:param name = "source" select = "'LOMv1.0'"/>
		<xsl:element name = "{$typeName}">
			<xsl:apply-templates select = "*">
				<xsl:with-param name = "source" select = "$source"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>

	<xsl:template match = "md:name">
		<xsl:param name = "nameName" select = "'name'"/>
		<xsl:param name = "source" select = "'LOMv1.0'"/>
		<xsl:element name = "{$nameName}">
			<xsl:apply-templates select = "*">
				<xsl:with-param name = "source" select = "$source"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>

	<xsl:template match = "md:minimumversion">
		<minimumVersion><xsl:value-of select = "."/></minimumVersion>
	</xsl:template>

	<xsl:template match = "md:maximumversion">
		<maximumVersion><xsl:value-of select = "."/></maximumVersion>
	</xsl:template>

	<!-- ==================================================================================  -->

	<!-- Educational Template and Children ************************************************ -->
	
	<xsl:template match = "md:educational">    
		<educational>
			<xsl:comment>Educational Section</xsl:comment>
			
			<xsl:apply-templates select = "*"/>
		</educational>
	</xsl:template>  

	<xsl:template match = "md:interactivitytype">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'interactivityType'"/>
			<xsl:with-param name = "alternateName" select = "'interactivityType'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:learningresourcetype">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'learningResourceType'"/>
			<xsl:with-param name = "alternateName" select = "'learningResourceType'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:interactivitylevel">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'interactivityLevel'"/>
			<xsl:with-param name = "alternateName" select = "'interactivityLevel'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:semanticdensity">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'semanticDensity'"/>
			<xsl:with-param name = "alternateName" select = "'semanticDensity'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:intendedenduserrole">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'intendedEndUserRole'"/>
			<xsl:with-param name = "alternateName" select = "'intendedEndUserRole'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:context">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'context'"/>
			<xsl:with-param name = "alternateName" select = "'context'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:difficulty">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'difficulty'"/>
			<xsl:with-param name = "alternateName" select = "'difficulty'"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match = "md:typicalagerange">
		<typicalAgeRange>
			<xsl:apply-templates select = "*"/>
		</typicalAgeRange>
	</xsl:template>

	<xsl:template match = "md:typicallearningtime">
		<typicalLearningTime>
			<xsl:apply-templates select = "*" mode = "duration"/>
		</typicalLearningTime>
	</xsl:template>

	<xsl:template match = "md:description" mode = "duration">
		<description>
			<xsl:apply-templates select = "*"/>
		</description>
	</xsl:template>

	<!-- ==================================================================================  -->

	<!-- Rights Template Children ********************************************************* -->
	
	<xsl:template match = "md:rights">    
		<rights>
			<xsl:comment>Rights Section</xsl:comment>
			<xsl:apply-templates select = "*"/>
			<xsl:call-template name = "wildcard"/>
		</rights>
	</xsl:template>  

	<xsl:template match = "md:cost">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'cost'"/>
			<xsl:with-param name = "alternateName" select = "'costOther'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:copyrightandotherrestrictions">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'copyrightAndOtherRestrictions'"/>
			<xsl:with-param name = "alternateName" select = "'copyrightAndOtherRestrictions'"/>
		</xsl:call-template>
	</xsl:template>

	<!-- ==================================================================================  -->

	<!-- Relations Template Children ****************************************************** -->
	
	<xsl:template match = "md:relation">    
		<relation>
			<xsl:comment>Relations Section</xsl:comment>
			<xsl:apply-templates select = "*"/>
			<xsl:call-template name = "wildcard"/>
		</relation>
	</xsl:template>  

	<xsl:template match = "md:kind">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'kind'"/>
			<xsl:with-param name = "alternateName" select = "'kindOther'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:resource">
		<resource>
			<xsl:call-template name = "catalogAndIdentifier"/>
			<xsl:apply-templates select = "md:description"/>
			<xsl:call-template name = "wildcard"/>
		</resource>
	</xsl:template>

	<!-- ==================================================================================  -->
	
	<!-- Annotation Template and Children ************************************************* -->
	
	<xsl:template match = "md:annotation">    
		<annotation>
			<xsl:comment>Annotation Section</xsl:comment>
			<xsl:apply-templates select = "*"/>
			<xsl:call-template name = "wildcard"/>
		</annotation>
	</xsl:template>
	  
	<xsl:template match = "md:person">
		<entity>
			<xsl:value-of select = "md:vcard"/>
		</entity>
	</xsl:template>

	<!-- ==================================================================================  -->
	
	<!-- Classification Template Children ************************************************* -->

	<xsl:template match = "md:classification">    
		<classification>
			<xsl:comment>Classification Section</xsl:comment>
			
			<xsl:apply-templates select = "*"/>
		</classification>  
	</xsl:template>

	<xsl:template match = "md:purpose">
		<xsl:call-template name = "vocabularyOther">
			<xsl:with-param name = "source" select = "md:source/md:langstring"/>
			<xsl:with-param name = "standardName" select = "'purpose'"/>
			<xsl:with-param name = "alternateName" select = "'purpose'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:taxonpath">
		<taxonPath>
			<xsl:apply-templates select = "md:taxon" mode = "taxonpath"/>
			<xsl:apply-templates select = "md:source" mode = "taxonpath"/>
		</taxonPath>
	</xsl:template>

	<xsl:template match = "md:taxon" mode = "taxonpath">
		<taxon>
			<xsl:apply-templates select = "md:id"/>
			<xsl:if test = "md:entry">
				<entry>
					<xsl:apply-templates select = "md:entry/md:langstring"/>
				</entry>
			</xsl:if>
		</taxon>
		<xsl:apply-templates select = "md:taxon" mode = "taxonpath"/>
	</xsl:template>

	<xsl:template match = "md:source" mode = "taxonpath">
		<source>
			<xsl:apply-templates select = "*"/>
		</source>
	</xsl:template>

	<!-- ==================================================================================  -->
	
	<!-- Utility Templates ****************************************************************  -->	
	<!-- These templates handle conversion of (possibly bogus) date and time data to the new
	     format. -->
	
	<xsl:template match = "md:datetime">
		<xsl:call-template name = "datetimeConversion">
			<xsl:with-param name = "data" select = "."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match = "md:datetime" mode = "duration">
			<xsl:call-template name = "durationConversion">
				<xsl:with-param name = "data" select = "."/>
			</xsl:call-template>
	</xsl:template>

	<!-- The 'check' variable below handles checking to see what the format of the data is. 
	     The usage of 'translate()' is patterned after the examples on pages 561-562 of "XSLT 2nd Edition:
	     Programmer's Reference", by Michael Kay, published by Wrox Press, ISBN 1-861005-06-7. -->

	<xsl:template name = "datetimeConversion">
		<xsl:param name = "data"/>
		<xsl:variable name = "check"
		              select = "translate($data, '0123456789d', 'dddddddddd ')"/>
		
		<!-- First, just check to see if the data is correct as is -->
		
		<xsl:choose>
			<xsl:when test = "starts-with($check, 'dddd-dd-ddTdd:dd:dd.d') or
			                  $check = 'dddd-dd-ddTdd:dd:dd' or
			                  $check = 'dddd-dd-dd' or
			                  $check = 'dddd-dd' or
			                  $check = 'dddd'">
				<dateTime>
					<xsl:value-of select = "$data"/>
				</dateTime>
			</xsl:when>

			<!-- ##DateTimeConversion -->
			<!-- If we get here, it means we have data which is not correct as is; see if we can translate it.
			     Users may want to add (or remove) translation mechanisms below. -->
			
			<xsl:when test = "$check = 'dddddddd'">
				<dateTime>
					<xsl:value-of select = "substring($data, 1, 4)"/>-<xsl:value-of select = "substring($data, 5, 2)"/>-<xsl:value-of select = "substring($data, 7, 2)"/>
				</dateTime>
			</xsl:when>
			<xsl:otherwise>
				<!-- 
				<dateTime>
					<xsl:value-of select = "$data"/>
				</dateTime>
				 -->
				<xsl:comment>This dateTime value <xsl:value-of select="$data"/> was omitted because it is not valid with respect to "DateTimeString" pattern.</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
		
	<xsl:template name = "durationConversion">
		<xsl:param name = "data"/>
		<xsl:variable name = "check"
		              select = "translate($data, '0123456789d', 'dddddddddd ')"/>		
		<xsl:choose>
			<xsl:when test = "starts-with($check, 'dddd-dd-ddTdd:dd:dd')">
				<xsl:variable name = "yearsVal">
					<xsl:call-template name = "durationConversionUtil">
						<xsl:with-param name = "substring" select = "substring($data, 1, 4)"/>
						<xsl:with-param name = "ending" select = "'Y'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "monthsVal">
					<xsl:call-template name = "durationConversionUtil">
						<xsl:with-param name = "substring" select = "substring($data, 6, 2)"/>
						<xsl:with-param name = "ending" select = "'M'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "daysVal">
					<xsl:call-template name = "durationConversionUtil">
						<xsl:with-param name = "substring" select = "substring($data, 9, 2)"/>
						<xsl:with-param name = "ending" select = "'D'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "hoursVal">
					<xsl:call-template name = "durationConversionUtil">
						<xsl:with-param name = "substring" select = "substring($data, 12, 2)"/>
						<xsl:with-param name = "ending" select = "'H'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "minutesVal">
					<xsl:call-template name = "durationConversionUtil">
						<xsl:with-param name = "substring" select = "substring($data, 15, 2)"/>
						<xsl:with-param name = "ending" select = "'M'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "secondsVal">
					<xsl:call-template name = "durationConversionUtil">
						<xsl:with-param name = "substring" select = "substring($data, 18)"/>
						<xsl:with-param name = "ending" select = "'S'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "separatorVal">
					<xsl:if test = "string-length($hoursVal) > 0 or string-length($minutesVal) > 0 or
					                string-length($secondsVal) > 0">
						<xsl:value-of select = "'T'"/>
					</xsl:if>
				</xsl:variable>

				<!-- Finally, assemble the entire package -->
				
				<xsl:variable name = "res">
					P
					<xsl:value-of select = "$yearsVal"/>
					<xsl:value-of select = "$monthsVal"/>
					<xsl:value-of select = "$daysVal"/>
					<xsl:value-of select = "$separatorVal"/>
					<xsl:value-of select = "$hoursVal"/>
					<xsl:value-of select = "$minutesVal"/>
					<xsl:value-of select = "$secondsVal"/>
				</xsl:variable>
				<duration>
					<xsl:value-of select = "translate(normalize-space($res), ' ', '')"/>
				</duration>
			</xsl:when>
			<xsl:otherwise>
					<!-- <xsl:value-of select = "$data"/> -->
					<xsl:comment>This duration value <xsl:value-of select="$data"/> was omitted because it is not valid with respect to "DurationString" pattern.</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name = "durationConversionUtil">
		<xsl:param name = "substring"/>
		<xsl:param name = "ending"/>
		<xsl:variable name = "check"
		              select = "translate($substring, '123456789z', 'zzzzzzzzz ')"/>
		<xsl:variable name = "val">
			<xsl:if test = "contains($check, 'z')">
				<xsl:value-of select = "concat($substring, $ending)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select = "$val"/>
	</xsl:template>

	<xsl:template match = "md:langstring">    
		<xsl:param name = "lang" select = "@xml:lang"/>
		<xsl:element name="string">
			<xsl:if test = "$lang">
				<xsl:attribute name = "language" namespace="">
					<xsl:value-of select = "$lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select = "."/>
		</xsl:element>
	</xsl:template>

	<!-- This template handles the conversion of source/value vocabularies to the new binding
	     format. There are two sets of source/value child templates; one for LOM vocabularies,
	     and one for non-LOM vocabularies. -->

	<xsl:template name = "vocabularyOther">
		<xsl:param name = "source"/>
		<xsl:param name = "standardName"/>
		<xsl:param name = "alternateName"/>
		<xsl:choose>
			<xsl:when test = "$source != 'LOMv1.0'">
				<xsl:element name = "{$alternateName}">
					<xsl:apply-templates select = "*" mode = "nonLOM"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name = "{$standardName}">
					<xsl:apply-templates select = "*"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match = "md:source" mode = "nonLOM">
		<xsl:element name = "source">
			<xsl:value-of select = "md:langstring"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match = "md:value" mode = "nonLOM">
		<value>
			<xsl:value-of select = "md:langstring"/>
		</value>
	</xsl:template>
	
	<xsl:template match = "md:source"> 
		<xsl:param name = "source" select = "md:langstring"/>
		<xsl:element name = "source">
			<xsl:value-of select = "$source"/>
		</xsl:element>
	</xsl:template>

	
	<!-- The following template does all of the conversion from the old binding's vocabulary to
	     the new binding's vocabulary. It is used only for LOM vocabularies. 
	     
	     The basic rule is that the first character of every word in the token is converted to
	     lower case. If the token is only one word, only the first character is converted.
	     
	     There are some exceptions which are handled by the individual 'when' elements; the 
	     'otherwise' element does the standard case conversion described above.
	     
	     Note that the bulk of the 'when' elements are used to handle the change in vocabulary
	     for element 5.6 Context from the IMS binding to the LOM binding. Users may want to check
	     to see that the choice of token translation agrees with their use. -->
	     
	<xsl:template match = "md:value">
		<xsl:variable name = "val" select = "md:langstring"/>
		<value>
			<xsl:choose>
			
			<!-- ##VocabularyTokenReplacement -->
			
				<xsl:when test = "$val = 'Microsoft Internet Explorer'">ms-internet explorer</xsl:when>
				<xsl:when test = "$val = 'MS-Windows'">ms-windows</xsl:when>
				<xsl:when test = "$val = 'Primary Education'">school</xsl:when>
				<xsl:when test = "$val = 'Secondary Education'">school</xsl:when>
				<xsl:when test = "$val = 'University First Cycle'">higher education</xsl:when>
				<xsl:when test = "$val = 'University Second Cycle'">higher education</xsl:when>
				<xsl:when test = "$val = 'University Postgrade'">higher education</xsl:when>
				<xsl:when test = "$val = 'Technical School First Cycle'">higher education</xsl:when>
				<xsl:when test = "$val = 'Technical School Second Cycle'">higher education</xsl:when>
				<xsl:when test = "$val = 'Professional Formation'">training</xsl:when>
				<xsl:when test = "$val = 'Continuous Formation'">other</xsl:when>
				<xsl:when test = "$val = 'Vocational Training'">training</xsl:when>
				
				<!-- Possibly need to add tokens here. To add a new token, change the OLD and NEW below
				     to the values that you want, and then copy that text out of the comment into the
				     logic above.
				     
				<xsl:when test = "$val = 'OLD'">NEW</xsl:when>
				     -->
				
				<xsl:otherwise>
					<xsl:call-template name = "translateToken">
						<xsl:with-param name = "input" select = "$val"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</value>
	</xsl:template>

	<xsl:template name = "translateToken">
		<xsl:param name = "input"/>
		<xsl:choose>
			<xsl:when test = "contains($input, ' ')">
				<xsl:variable name = "first" select = "substring-before($input, ' ')"/>
				<xsl:variable name = "rest" select = "substring-after($input, ' ')"/>
				<xsl:variable name = "translateFirst">
					<xsl:call-template name = "translateWord">
						<xsl:with-param name = "word" select = "$first"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name = "translateRest">
					<xsl:call-template name = "translateToken">
						<xsl:with-param name = "input" select = "$rest"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select = "concat($translateFirst, ' ', $translateRest)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name = "translateWord">
					<xsl:with-param name = "word" select = "$input"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!--
	<xsl:template name = "translateWord">
		<xsl:param name = "word"/>
		<xsl:variable name = "char" select = "substring($word, 1, 1)"/>
		<xsl:variable name = "rest" select = "substring($word, 2)"/>
		<xsl:variable name = "translatedChar"
		              select = "translate($char, 
		                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                  'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:value-of select = "concat($translatedChar, $rest)"/>
	</xsl:template>

-->

	<xsl:template name = "translateWord">
		<xsl:param name = "word"/>
		<xsl:value-of select = "translate($word, 
		                                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		                                  'abcdefghijklmnopqrstuvwxyz')"/>
	</xsl:template>

	<!-- ==================================================================================  -->
	
	
	<!-- Template for parsing xsi:schemaLocation attribute and remove unnecessary schemas -->
	<xsl:template name="schemaMetadataLocationParsing">
    	<xsl:param name="original"/>
	<xsl:variable name="namespace" select="substring-before($original, ' ')"/>
	<xsl:variable name="schema">
		<xsl:variable name="rest" select="normalize-space(substring-after($original,$namespace))"/>
		<xsl:choose>
			<xsl:when test="contains($rest,' ')">
				<xsl:value-of select="substring-before($rest,' ')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$rest"/>
			</xsl:otherwise>
		</xsl:choose>	
		
	</xsl:variable>
	
	<xsl:variable name="remainder" select="normalize-space(substring-after($original,$schema))"/>
	<xsl:if test="$namespace!='http://ltsc.ieee.org/xsd/LOM'
		and $namespace!='http://www.imsglobal.org/xsd/imsmd_v1p2'">
		<xsl:value-of select="concat($namespace, ' ', $schema, ' ')"/>
	</xsl:if>
	<xsl:if test="contains($remainder,' ') ">
		<xsl:call-template name="schemaMetadataLocationParsing">
			<xsl:with-param name="original" select="$remainder"/>
		</xsl:call-template>
	</xsl:if>  
    </xsl:template>
	
	
</xsl:stylesheet>