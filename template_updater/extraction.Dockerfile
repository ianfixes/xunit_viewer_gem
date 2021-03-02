FROM node:latest

# first install software
RUN npm i -g xunit-viewer

# create dummy input placeholder
RUN echo "<testsuite><testcase name='foo'></testcase></testsuite>" > blarg.xml

# accept a name for the output report, ".html" automatically appended if not already there!
ARG OUTPUT_HTML_NAME=report_template
RUN timeout 5 xunit-viewer \
  --server false \
  --watch false \
  --output $OUTPUT_HTML_NAME \
  --title BLARG_TITLE \
  --brand BLARG_BRAND \
  --favicon BLARG_FAVICON \
  --results blarg.xml \
  ; true

RUN echo $OUTPUT_HTML_NAME && test -f $OUTPUT_HTML_NAME
