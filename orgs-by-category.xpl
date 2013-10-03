<?xml version="1.0" encoding="UTF-8" ?>
<p:pipeline version="1.0"
        xmlns:p="http://www.w3.org/ns/xproc"
        xmlns:c="http://www.w3.org/ns/xproc-step"
        xmlns:l="http://xproc.org/library">

<p:serialization port="result" media-type="application/json" method="text" />

<p:xslt>
    <p:input port="stylesheet">
        <p:document href="categories2json.xsl" />
    </p:input>
    <p:input port="source">
        <p:document href="orgs-by-category.rq?results" />
    </p:input>
</p:xslt>

</p:pipeline>