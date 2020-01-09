<?php

$saxonProcessor = new Saxon\SaxonProcessor();

error_log("Creating processor...\n");
$processor = $saxonProcessor->newXsltProcessor();
error_log("Created processor...\n");

// show that the XSL file can be read
//error_log(file_get_contents(__DIR__ . '/example.xsl'));

error_log("Compiling XSL...\n");
$processor->compileFromFile(__DIR__ . '/example.xsl');
error_log("Compiled XSL...\n");

//error_log("Reading source...\n");
//$processor->setSourceFromFile(__DIR__ . '/example.xml');
//error_log("Read source...\n");
//
//print $processor->transformToString();
