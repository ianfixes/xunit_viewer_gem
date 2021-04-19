FROM node:latest

# first install software
RUN npm i -g xunit-viewer@7.0.3

# create dummy input placeholder
RUN echo "<testsuite><testcase name='foo'></testcase></testsuite>" > blarg.xml

# accept a name for the output report, ".html" automatically appended if not already there!
ARG OUTPUT_HTML_NAME=report_template.html
RUN xunit-viewer \
  --server false \
  --watch false \
  --output $OUTPUT_HTML_NAME \
  --title BLARG_TITLE \
  --brand BLARG_BRAND \
  --favicon BLARG_FAVICON \
  --results blarg.xml

RUN echo $OUTPUT_HTML_NAME && test -f $OUTPUT_HTML_NAME
