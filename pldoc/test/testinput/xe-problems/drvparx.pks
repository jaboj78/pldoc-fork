create or replace
package drvparx authid current_user is
   FUNCTION ParallelPopuIndex(
     cur        SYS_REFCURSOR,
     idxownid   number,
     idxid      number,
     idxo       varchar2,
     idxn       varchar2,
     idxp       varchar2,
     idxpopstate dr$popindex_state_t)
       return sys.odcivarchar2list
      parallel_enable(partition cur by any) pipelined;

   FUNCTION IndexOptimizeParFn(
     crsr        in drvddl.popcurtyp,
     idxownid    in number,
     idxowner    in varchar2,
     idxname     in varchar2,
     ixpname     in varchar2,
     shadow_itab in varchar2,
     nextid     in number,
     optstate    in dr$optim_state_t
   ) return sys.odcivarchar2list
     pipelined parallel_enable (partition crsr BY HASH(num));

   FUNCTION TraceGetTrace return dr$trc_tab;

/*------------- Mapping Attributes into Existing Documents -----------------*/

type map_rec_t is record(map_docid number, map_data  varchar2(4000));
type map_typ_cur is ref cursor return map_rec_t;

-- process input documents as mdata
MAP_DOC_MODE_MDATA constant number := 0;

/* Main Mapping function */
function IndexMapDocuments(
    crsr     in drvparx.map_typ_cur,
    ownid    in number,
    owner    in varchar2,
    idxname  in varchar2,
    partname in varchar2,
    flags    in binary_integer,
    sectyp   in binary_integer
) return dr$mapdoc_set_t
  pipelined
  order crsr by (map_docid)
  parallel_enable (partition crsr by range(map_docid));

/* Create sublex tokens given language column */
function CreateSublexTokens(
  crsr   in drvparx.map_typ_cur
) return dr$mapdoc_set_t
  pipelined
  parallel_enable (partition crsr by any);

end drvparx;

