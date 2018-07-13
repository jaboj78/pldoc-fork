create or replace
PACKAGE CTX_MATCHES AUTHID CURRENT_USER AS
function  matches(
  Colval  in     varchar2,
  Text    in     varchar2,
  ia      in     sys.odciindexctx,
  sctx    in out RuleIndexMethods,
  cflg    in     number
)
  return number parallel_enable is language C
  name "rulematches"
  library dr$lib
  with context
  parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        Text LENGTH,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );

function matches(
  Colval  in     clob,
  Text    in     varchar2,
  ia      in     sys.odciindexctx,
  sctx    in out RuleIndexMethods,
  cflg    in     number
)
  return number parallel_enable is language C
  name "rulematches"
  library dr$lib
  with context
  parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        Text LENGTH,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );

function matches(
  Colval  in     blob,
  Text    in     varchar2,
  ia      in     sys.odciindexctx,
  sctx    in out RuleIndexMethods,
  cflg    in     number
)
  return number parallel_enable is language C
  name "rulematches"
  library dr$lib
  with context
  parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        Text LENGTH,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );

function matches(
  Colval  in     varchar2,
  Text    in     clob,
  ia      in     sys.odciindexctx,
  sctx    in out RuleIndexMethods,
  cflg    in     number
)
  return number parallel_enable is language C
  name "rulematches"
  library dr$lib
  with context
  parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        Text CHARSETID,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );

function matches(
  Colval  in     clob,
  Text    in     clob,
  ia      in     sys.odciindexctx,
  sctx    in out RuleIndexMethods,
  cflg    in     number
)
  return number parallel_enable is language C
  name "rulematches"
  library dr$lib
  with context
  parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        Text CHARSETID,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );

function matches(
  Colval  in     blob,
  Text    in     clob,
  ia      in     sys.odciindexctx,
  sctx    in out RuleIndexMethods,
  cflg    in     number
)
  return number parallel_enable is language C
  name "rulematches"
  library dr$lib
  with context
  parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        Text CHARSETID,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );
end ctx_matches;

