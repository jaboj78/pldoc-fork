create or replace
procedure syncrn (
  ownid IN binary_integer,
  oname IN varchar2,
  idxid IN binary_integer,
  ixpid IN binary_integer,
  rtabnm IN varchar2,
  srcflg IN binary_integer
)
  authid definer
  as external
  name "comt_cb"
  library dr$lib
  with context
  parameters(
    context,
    ownid  ub4,
    oname  OCISTRING,
    idxid  ub4,
    ixpid  ub4,
    rtabnm OCISTRING,
    srcflg ub1
);

