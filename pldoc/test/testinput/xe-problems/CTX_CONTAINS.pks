create or replace
package ctx_contains authid current_user as
    -- varchar2 column type, varchar2 query string type
    function Textcontains(Colval in varchar2,
                             Text in varchar2, ia sys.odciindexctx,
                             sctx IN OUT TextIndexMethods,
                             cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains"
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
    -- varchar2 column type, clob query string type
    function Textcontains(Colval in varchar2,
                             Text in clob, ia sys.odciindexctx,
                             sctx IN OUT TextIndexMethods,
                             cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains_clob"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );
    -- clob column type, varchar2 query string type
    function Textcontains(Colval in clob,
                                Text in varchar2, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv */)
      return number parallel_enable is language C
      name "contains"
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
    -- clob column type, clob query string type
    function Textcontains(Colval in clob,
                                Text in clob, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv */)
      return number parallel_enable is language C
      name "contains_clob"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );
    -- blob column type, varchar2 query string type
    function Textcontains(Colval in blob,
                                Text in varchar2, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains"
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
    -- blob column type, clob query string type
    function Textcontains(Colval in blob,
                                Text in clob, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains_clob"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );
    -- bfile column type, varchar2 query string type
    function Textcontains(Colval in bfile,
                                Text in varchar2, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv */)
      return number parallel_enable is language C
      name "contains"
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
    -- bfile column type, clob query string type
    function Textcontains(Colval in bfile,
                                Text in clob, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv */)
      return number parallel_enable is language C
      name "contains_clob"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );
    -- Xmltype column type, varchar2 query string type
    function Textcontains(Colval in sys.xmltype,
                                Text in varchar2, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains"
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
    -- Xmltype column type, clob query string type
    function Textcontains(Colval in sys.xmltype,
                                Text in clob, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains_clob"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR,
        Text,
        Text INDICATOR,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );
    -- Uritype column type, varchar2 query string type
    function Textcontains(Colval in sys.uritype,
                                Text in varchar2, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR STRUCT,
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
    -- Uritype column type, clob query string type
    function Textcontains(Colval in sys.uritype,
                                Text in clob, ia sys.odciindexctx,
                                sctx IN OUT TextIndexMethods,
                                cflg number /*, env sys.ODCIEnv*/)
      return number parallel_enable is language C
      name "contains_clob"
      library dr$lib
      with context
      parameters(
        context,
        Colval,
        Colval INDICATOR STRUCT,
        Text,
        Text INDICATOR,
        ia,
        ia INDICATOR STRUCT,
        sctx,
        sctx INDICATOR STRUCT,
        cflg,
        cflg INDICATOR,
        return OCINumber
      );

end ctx_contains;

