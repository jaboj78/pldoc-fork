SET LINES 160 PAGES 60
CREATE OR REPLACE FUNCTION 
fnc_test_unreserved_keyword
  /** 
  *<p>
  *This procedure is based on {@link pkg_test_unreserved_keyword} and the variable definitions should be kept sychronised to that packae
  *specification.
  *</p>
  *
  *<p>
  *using variables that are keywords in schema-level functions and procedures There are more restrictions in using variables that are keywords in schema-level functions and procedures (for example the keyword CASE may be declared as a variable in th declaration section, but fails to parse when assigned to in the procedure body. 
  *</p>
  *
  *<ul>
  *<p>
  *The problem keywords are those highlighted in GVIM (railscast.vim colour schema with plsql.vim syntax highlighting):-
  *</p>
  *<li>brown - plsqlKeyWord </li>
  *<li>red   - plsqlStorage</li>
  *<li>brown - plsqlKeyWord </li>
  *</ul>
  *
  * @param P_A Unreserved keyword - P_A
  * @param P_ABORT Unreserved keyword - P_ABORT
  * @param P_ACCESS Unreserved keyword - P_ACCESS
  * @param P_ACCESSED Unreserved keyword - P_ACCESSED
  * @param P_ACCOUNT Unreserved keyword - P_ACCOUNT
  * @param P_ACTIVATE Unreserved keyword - P_ACTIVATE
  * @param P_ADD Unreserved keyword - P_ADD
  * @param P_ADMIN Unreserved keyword - P_ADMIN
  * @param P_ADMINISTER Unreserved keyword - P_ADMINISTER
  * @param P_ADMINISTRATOR Unreserved keyword - P_ADMINISTRATOR
  * @param P_ADVISE Unreserved keyword - P_ADVISE
  * @param P_ADVISOR Unreserved keyword - P_ADVISOR
  * @param P_AFTER Unreserved keyword - P_AFTER
  * @param P_AGGREGATE Unreserved keyword - P_AGGREGATE
  * @param P_ALIAS Unreserved keyword - P_ALIAS
  * @param P_ALL_ROWS Unreserved keyword - P_ALL_ROWS
  * @param P_ALLOCATE Unreserved keyword - P_ALLOCATE
  * @param P_ALLOW Unreserved keyword - P_ALLOW
  * @param P_ALWAYS Unreserved keyword - P_ALWAYS
  * @param P_ANALYZE Unreserved keyword - P_ANALYZE
  * @param P_ANCILLARY Unreserved keyword - P_ANCILLARY
  * @param P_AND_EQUAL Unreserved keyword - P_AND_EQUAL
  * @param P_ANTIJOIN Unreserved keyword - P_ANTIJOIN
  * @param P_APPEND Unreserved keyword - P_APPEND
  * @param P_APPLY Unreserved keyword - P_APPLY
  * @param P_ARCHIVE Unreserved keyword - P_ARCHIVE
  * @param P_ARCHIVELOG Unreserved keyword - P_ARCHIVELOG
  * @param P_ARRAY Unreserved keyword - P_ARRAY
  * @param P_ASSOCIATE Unreserved keyword - P_ASSOCIATE
  * @param P_AT Unreserved keyword - P_AT
  * @param P_ATTRIBUTE Unreserved keyword - P_ATTRIBUTE
  * @param P_ATTRIBUTES Unreserved keyword - P_ATTRIBUTES
  * @param P_AUDIT Unreserved keyword - P_AUDIT
  * @param P_AUTHENTICATED Unreserved keyword - P_AUTHENTICATED
  * @param P_AUTHENTICATION Unreserved keyword - P_AUTHENTICATION
  * @param P_AUTHID Unreserved keyword - P_AUTHID
  * @param P_AUTHORIZATION Unreserved keyword - P_AUTHORIZATION
  * @param P_AUTO Unreserved keyword - P_AUTO
  * @param P_AUTOALLOCATE Unreserved keyword - P_AUTOALLOCATE
  * @param P_AUTOEXTEND Unreserved keyword - P_AUTOEXTEND
  * @param P_AUTOMATIC Unreserved keyword - P_AUTOMATIC
  * @param P_AVAILABILITY Unreserved keyword - P_AVAILABILITY
  * @param P_BACKUP Unreserved keyword - P_BACKUP
  * @param P_BATCH Unreserved keyword - P_BATCH
  * @param P_BECOME Unreserved keyword - P_BECOME
  * @param P_BEFORE Unreserved keyword - P_BEFORE
  * @param P_BEGIN Unreserved keyword - P_BEGIN
  * @param P_BEGIN_OUTLINE_DATA Unreserved keyword - P_BEGIN_OUTLINE_DATA
  * @param P_BEHALF Unreserved keyword - P_BEHALF
  * @param P_BFILE Unreserved keyword - P_BFILE
  * @param P_BIGFILE Unreserved keyword - P_BIGFILE
  * @param P_BINARY_DOUBLE Unreserved keyword - P_BINARY_DOUBLE
  * @param P_BINARY_DOUBLE_INFINITY Unreserved keyword - P_BINARY_DOUBLE_INFINITY
  * @param P_BINARY_DOUBLE_NAN Unreserved keyword - P_BINARY_DOUBLE_NAN
  * @param P_BINARY_FLOAT Unreserved keyword - P_BINARY_FLOAT
  * @param P_BINARY_FLOAT_INFINITY Unreserved keyword - P_BINARY_FLOAT_INFINITY
  * @param P_BINARY_FLOAT_NAN Unreserved keyword - P_BINARY_FLOAT_NAN
  * @param P_BINDING Unreserved keyword - P_BINDING
  * @param P_BITMAP Unreserved keyword - P_BITMAP
  * @param P_BITMAP_TREE Unreserved keyword - P_BITMAP_TREE
  * @param P_BITMAPS Unreserved keyword - P_BITMAPS
  * @param P_BITS Unreserved keyword - P_BITS
  * @param P_BLOB Unreserved keyword - P_BLOB
  * @param P_BLOCK Unreserved keyword - P_BLOCK
  * @param P_BLOCK_RANGE Unreserved keyword - P_BLOCK_RANGE
  * @param P_BLOCKS Unreserved keyword - P_BLOCKS
  * @param P_BLOCKSIZE Unreserved keyword - P_BLOCKSIZE
  * @param P_BODY Unreserved keyword - P_BODY
  * @param P_BOTH Unreserved keyword - P_BOTH
  * @param P_BOUND Unreserved keyword - P_BOUND
  * @param P_BROADCAST Unreserved keyword - P_BROADCAST
  * @param P_BUFFER Unreserved keyword - P_BUFFER
  * @param P_BUFFER_CACHE Unreserved keyword - P_BUFFER_CACHE
  * @param P_BUFFER_POOL Unreserved keyword - P_BUFFER_POOL
  * @param P_BUILD Unreserved keyword - P_BUILD
  * @param P_BULK Unreserved keyword - P_BULK
  * @param P_BYPASS_RECURSIVE_CHECK Unreserved keyword - P_BYPASS_RECURSIVE_CHECK
  * @param P_BYPASS_UJVC Unreserved keyword - P_BYPASS_UJVC
  * @param P_BY Unreserved keyword - P_BY
  * @param P_BYTE Unreserved keyword - P_BYTE
  * @param P_CACHE Unreserved keyword - P_CACHE
  * @param P_CACHE_CB Unreserved keyword - P_CACHE_CB
  * @param P_CACHE_INSTANCES Unreserved keyword - P_CACHE_INSTANCES
  * @param P_CACHE_TEMP_TABLE Unreserved keyword - P_CACHE_TEMP_TABLE
  * @param P_CALL Unreserved keyword - P_CALL
  * @param P_CANCEL Unreserved keyword - P_CANCEL
  * @param P_CARDINALITY Unreserved keyword - P_CARDINALITY
  * @param P_CASCADE Unreserved keyword - P_CASCADE
  * @param P_CASE Unreserved keyword - P_CASE
  * @param P_CAST Unreserved keyword - P_CAST
  * @param P_CATEGORY Unreserved keyword - P_CATEGORY
  * @param P_CERTIFICATE Unreserved keyword - P_CERTIFICATE
  * @param P_CFILE Unreserved keyword - P_CFILE
  * @param P_CHAINED Unreserved keyword - P_CHAINED
  * @param P_CHANGE Unreserved keyword - P_CHANGE
  * @param P_CHAR_CS Unreserved keyword - P_CHAR_CS
  * @param P_CHARACTER Unreserved keyword - P_CHARACTER
  * @param P_CHECKPOINT Unreserved keyword - P_CHECKPOINT
  * @param P_CHILD Unreserved keyword - P_CHILD
  * @param P_CHOOSE Unreserved keyword - P_CHOOSE
  * @param P_CHUNK Unreserved keyword - P_CHUNK
  * @param P_CIV_GB Unreserved keyword - P_CIV_GB
  * @param P_CLASS Unreserved keyword - P_CLASS
  * @param P_CLEAR Unreserved keyword - P_CLEAR
  * @param P_CLOB Unreserved keyword - P_CLOB
  * @param P_CLONE Unreserved keyword - P_CLONE
  * @param P_CLOSE Unreserved keyword - P_CLOSE
  * @param P_CLOSE_CACHED_OPEN_CURSORS Unreserved keyword - P_CLOSE_CACHED_OPEN_CURSORS
  * @param P_CLUSTERING_FACTOR Unreserved keyword - P_CLUSTERING_FACTOR
  * @param P_COALESCE Unreserved keyword - P_COALESCE
  * @param P_COARSE Unreserved keyword - P_COARSE
  * @param P_COLLECT Unreserved keyword - P_COLLECT
  * @param P_COLUMN Unreserved keyword - P_COLUMN
  * @param P_COLUMN_STATS Unreserved keyword - P_COLUMN_STATS
  * @param P_COLUMN_VALUE Unreserved keyword - P_COLUMN_VALUE
  * @param P_COLUMNS Unreserved keyword - P_COLUMNS
  * @param P_COMMENT Unreserved keyword - P_COMMENT
  * @param P_COMMIT Unreserved keyword - P_COMMIT
  * @param P_COMMITTED Unreserved keyword - P_COMMITTED
  * @param P_COMPACT Unreserved keyword - P_COMPACT
  * @param P_COMPATIBILITY Unreserved keyword - P_COMPATIBILITY
  * @param P_COMPILE Unreserved keyword - P_COMPILE
  * @param P_COMPLETE Unreserved keyword - P_COMPLETE
  * @param P_COMPOSITE_LIMIT Unreserved keyword - P_COMPOSITE_LIMIT
  * @param P_COMPUTE Unreserved keyword - P_COMPUTE
  * @param P_CONFORMING Unreserved keyword - P_CONFORMING
  * @param P_CONNECT_BY_COST_BASED Unreserved keyword - P_CONNECT_BY_COST_BASED
  * @param P_CONNECT_BY_FILTERING Unreserved keyword - P_CONNECT_BY_FILTERING
  * @param P_CONNECT_BY_ISCYCLE Unreserved keyword - P_CONNECT_BY_ISCYCLE
  * @param P_CONNECT_BY_ISLEAF Unreserved keyword - P_CONNECT_BY_ISLEAF
  * @param P_CONNECT_BY_ROOT Unreserved keyword - P_CONNECT_BY_ROOT
  * @param P_CONNECT_TIME Unreserved keyword - P_CONNECT_TIME
  * @param P_CONSIDER Unreserved keyword - P_CONSIDER
  * @param P_CONSISTENT Unreserved keyword - P_CONSISTENT
  * @param P_CONSTRAINT Unreserved keyword - P_CONSTRAINT
  * @param P_CONSTRAINTS Unreserved keyword - P_CONSTRAINTS
  * @param P_CONTAINER Unreserved keyword - P_CONTAINER
  * @param P_CONTENT Unreserved keyword - P_CONTENT
  * @param P_CONTENTS Unreserved keyword - P_CONTENTS
  * @param P_CONTEXT Unreserved keyword - P_CONTEXT
  * @param P_CONTINUE Unreserved keyword - P_CONTINUE
  * @param P_CONTROLFILE Unreserved keyword - P_CONTROLFILE
  * @param P_CONVERT Unreserved keyword - P_CONVERT
  * @param P_CORRUPTION Unreserved keyword - P_CORRUPTION
  * @param P_COST Unreserved keyword - P_COST
  * @param P_CPU_COSTING Unreserved keyword - P_CPU_COSTING
  * @param P_CPU_PER_CALL Unreserved keyword - P_CPU_PER_CALL
  * @param P_CPU_PER_SESSION Unreserved keyword - P_CPU_PER_SESSION
  * @param P_CREATE_STORED_OUTLINES Unreserved keyword - P_CREATE_STORED_OUTLINES
  * @param P_CROSS Unreserved keyword - P_CROSS
  * @param P_CUBE Unreserved keyword - P_CUBE
  * @param P_CUBE_GB Unreserved keyword - P_CUBE_GB
  * @param P_CURRENT Unreserved keyword - P_CURRENT
  * @param P_CURRENT_DATE Unreserved keyword - P_CURRENT_DATE
  * @param P_CURRENT_SCHEMA Unreserved keyword - P_CURRENT_SCHEMA
  * @param P_CURRENT_TIME Unreserved keyword - P_CURRENT_TIME
  * @param P_CURRENT_TIMESTAMP Unreserved keyword - P_CURRENT_TIMESTAMP
  * @param P_CURRENT_USER Unreserved keyword - P_CURRENT_USER
  * @param P_CURSOR Unreserved keyword - P_CURSOR
  * @param P_CURSOR_SHARING_EXACT Unreserved keyword - P_CURSOR_SHARING_EXACT
  * @param P_CURSOR_SPECIFIC_SEGMENT Unreserved keyword - P_CURSOR_SPECIFIC_SEGMENT
  * @param P_CYCLE Unreserved keyword - P_CYCLE
  * @param P_DANGLING Unreserved keyword - P_DANGLING
  * @param P_DATA Unreserved keyword - P_DATA
  * @param P_DATABASE Unreserved keyword - P_DATABASE
  * @param P_DATAFILE Unreserved keyword - P_DATAFILE
  * @param P_DATAFILES Unreserved keyword - P_DATAFILES
  * @param P_DATAOBJNO Unreserved keyword - P_DATAOBJNO
  * @param P_DATE_MODE Unreserved keyword - P_DATE_MODE
  * @param P_DAY Unreserved keyword - P_DAY
  * @param P_DB_ROLE_CHANGE Unreserved keyword - P_DB_ROLE_CHANGE
  * @param P_DBA Unreserved keyword - P_DBA
  * @param P_DBA_RECYCLEBIN Unreserved keyword - P_DBA_RECYCLEBIN
  * @param P_DBMS_STATS Unreserved keyword - P_DBMS_STATS
  * @param P_DBTIMEZONE Unreserved keyword - P_DBTIMEZONE
  * @param P_DDL Unreserved keyword - P_DDL
  * @param P_DEALLOCATE Unreserved keyword - P_DEALLOCATE
  * @param P_DEBUG Unreserved keyword - P_DEBUG
  * @param P_DEC Unreserved keyword - P_DEC
  * @param P_DECLARE Unreserved keyword - P_DECLARE
  * @param P_DECREMENT Unreserved keyword - P_DECREMENT
  * @param P_DECRYPT Unreserved keyword - P_DECRYPT
  * @param P_DEFERRABLE Unreserved keyword - P_DEFERRABLE
  * @param P_DEFERRED Unreserved keyword - P_DEFERRED
  * @param P_DEFINED Unreserved keyword - P_DEFINED
  * @param P_DEFINER Unreserved keyword - P_DEFINER
  * @param P_DEGREE Unreserved keyword - P_DEGREE
  * @param P_DELAY Unreserved keyword - P_DELAY
  * @param P_DEMAND Unreserved keyword - P_DEMAND
  * @param P_DENSE_RANK Unreserved keyword - P_DENSE_RANK
  * @param P_DEQUEUE Unreserved keyword - P_DEQUEUE
  * @param P_DEREF Unreserved keyword - P_DEREF
  * @param P_DEREF_NO_REWRITE Unreserved keyword - P_DEREF_NO_REWRITE
  * @param P_DETACHED Unreserved keyword - P_DETACHED
  * @param P_DETERMINES Unreserved keyword - P_DETERMINES
  * @param P_DICTIONARY Unreserved keyword - P_DICTIONARY
  * @param P_DIMENSION Unreserved keyword - P_DIMENSION
  * @param P_DIRECTORY Unreserved keyword - P_DIRECTORY
  * @param P_DISABLE Unreserved keyword - P_DISABLE
  * @param P_DISABLE_RPKE Unreserved keyword - P_DISABLE_RPKE
  * @param P_DISASSOCIATE Unreserved keyword - P_DISASSOCIATE
  * @param P_DISCONNECT Unreserved keyword - P_DISCONNECT
  * @param P_DISK Unreserved keyword - P_DISK
  * @param P_DISKGROUP Unreserved keyword - P_DISKGROUP
  * @param P_DISKS Unreserved keyword - P_DISKS
  * @param P_DISMOUNT Unreserved keyword - P_DISMOUNT
  * @param P_DISTINGUISHED Unreserved keyword - P_DISTINGUISHED
  * @param P_DISTRIBUTED Unreserved keyword - P_DISTRIBUTED
  * @param P_DML Unreserved keyword - P_DML
  * @param P_DML_UPDATE Unreserved keyword - P_DML_UPDATE
  * @param P_DOCUMENT Unreserved keyword - P_DOCUMENT
  * @param P_DOMAIN_INDEX_NO_SORT Unreserved keyword - P_DOMAIN_INDEX_NO_SORT
  * @param P_DOMAIN_INDEX_SORT Unreserved keyword - P_DOMAIN_INDEX_SORT
  * @param P_DOUBLE Unreserved keyword - P_DOUBLE
  * @param P_DOWNGRADE Unreserved keyword - P_DOWNGRADE
  * @param P_DRIVING_SITE Unreserved keyword - P_DRIVING_SITE
  * @param P_DUMP Unreserved keyword - P_DUMP
  * @param P_DYNAMIC Unreserved keyword - P_DYNAMIC
  * @param P_DYNAMIC_SAMPLING Unreserved keyword - P_DYNAMIC_SAMPLING
  * @param P_DYNAMIC_SAMPLING_EST_CDN Unreserved keyword - P_DYNAMIC_SAMPLING_EST_CDN
  * @param P_E Unreserved keyword - P_E
  * @param P_EACH Unreserved keyword - P_EACH
  * @param P_ELEMENT Unreserved keyword - P_ELEMENT
  * @param P_ELIMINATE_JOIN Unreserved keyword - P_ELIMINATE_JOIN
  * @param P_ELIMINATE_OBY Unreserved keyword - P_ELIMINATE_OBY
  * @param P_ELIMINATE_OUTER_JOIN Unreserved keyword - P_ELIMINATE_OUTER_JOIN
  * @param P_EMPTY Unreserved keyword - P_EMPTY
  * @param P_ENABLE Unreserved keyword - P_ENABLE
  * @param P_ENCRYPT Unreserved keyword - P_ENCRYPT
  * @param P_ENCRYPTION Unreserved keyword - P_ENCRYPTION
  * @param P_END Unreserved keyword - P_END
  * @param P_END_OUTLINE_DATA Unreserved keyword - P_END_OUTLINE_DATA
  * @param P_ENFORCE Unreserved keyword - P_ENFORCE
  * @param P_ENFORCED Unreserved keyword - P_ENFORCED
  * @param P_ENQUEUE Unreserved keyword - P_ENQUEUE
  * @param P_ENTERPRISE Unreserved keyword - P_ENTERPRISE
  * @param P_ENTRY Unreserved keyword - P_ENTRY
  * @param P_ERROR Unreserved keyword - P_ERROR
  * @param P_ERROR_ON_OVERLAP_TIME Unreserved keyword - P_ERROR_ON_OVERLAP_TIME
  * @param P_ERRORS Unreserved keyword - P_ERRORS
  * @param P_ESCAPE Unreserved keyword - P_ESCAPE
  * @param P_ESTIMATE Unreserved keyword - P_ESTIMATE
  * @param P_EVALNAME Unreserved keyword - P_EVALNAME
  * @param P_EVALUATION Unreserved keyword - P_EVALUATION
  * @param P_EVENTS Unreserved keyword - P_EVENTS
  * @param P_EXCEPT Unreserved keyword - P_EXCEPT
  * @param P_EXCEPTIONS Unreserved keyword - P_EXCEPTIONS
  * @param P_EXCHANGE Unreserved keyword - P_EXCHANGE
  * @param P_EXCLUDING Unreserved keyword - P_EXCLUDING
  * @param P_EXECUTE Unreserved keyword - P_EXECUTE
  * @param P_EXEMPT Unreserved keyword - P_EXEMPT
  * @param P_EXPAND_GSET_TO_UNION Unreserved keyword - P_EXPAND_GSET_TO_UNION
  * @param P_EXPIRE Unreserved keyword - P_EXPIRE
  * @param P_EXPLAIN Unreserved keyword - P_EXPLAIN
  * @param P_EXPLOSION Unreserved keyword - P_EXPLOSION
  * @param P_EXPORT Unreserved keyword - P_EXPORT
  * @param P_EXPR_CORR_CHECK Unreserved keyword - P_EXPR_CORR_CHECK
  * @param P_EXTENDS Unreserved keyword - P_EXTENDS
  * @param P_EXTENT Unreserved keyword - P_EXTENT
  * @param P_EXTENTS Unreserved keyword - P_EXTENTS
  * @param P_EXTERNAL Unreserved keyword - P_EXTERNAL
  * @param P_EXTERNALLY Unreserved keyword - P_EXTERNALLY
  * @param P_EXTRACT Unreserved keyword - P_EXTRACT
  * @param P_FACT Unreserved keyword - P_FACT
  * @param P_FAILED Unreserved keyword - P_FAILED
  * @param P_FAILED_LOGIN_ATTEMPTS Unreserved keyword - P_FAILED_LOGIN_ATTEMPTS
  * @param P_FAILGROUP Unreserved keyword - P_FAILGROUP
  * @param P_FALSE Unreserved keyword - P_FALSE
  * @param P_FAST Unreserved keyword - P_FAST
  * @param P_FBTSCAN Unreserved keyword - P_FBTSCAN
  * @param P_FIC_CIV Unreserved keyword - P_FIC_CIV
  * @param P_FIC_PIV Unreserved keyword - P_FIC_PIV
  * @param P_FILE Unreserved keyword - P_FILE
  * @param P_FILTER Unreserved keyword - P_FILTER
  * @param P_FINAL Unreserved keyword - P_FINAL
  * @param P_FINE Unreserved keyword - P_FINE
  * @param P_FINISH Unreserved keyword - P_FINISH
  * @param P_FIRST Unreserved keyword - P_FIRST
  * @param P_FIRST_ROWS Unreserved keyword - P_FIRST_ROWS
  * @param P_FLAGGER Unreserved keyword - P_FLAGGER
  * @param P_FLASHBACK Unreserved keyword - P_FLASHBACK
  * @param P_FLOB Unreserved keyword - P_FLOB
  * @param P_FLUSH Unreserved keyword - P_FLUSH
  * @param P_FOLLOWING Unreserved keyword - P_FOLLOWING
  * @param P_FORCE Unreserved keyword - P_FORCE
  * @param P_FORCE_XML_QUERY_REWRITE Unreserved keyword - P_FORCE_XML_QUERY_REWRITE
  * @param P_FOREIGN Unreserved keyword - P_FOREIGN
  * @param P_FREELIST Unreserved keyword - P_FREELIST
  * @param P_FREELISTS Unreserved keyword - P_FREELISTS
  * @param P_FREEPOOLS Unreserved keyword - P_FREEPOOLS
  * @param P_FRESH Unreserved keyword - P_FRESH
  * @param P_FULL Unreserved keyword - P_FULL
  * @param P_FUNCTION Unreserved keyword - P_FUNCTION
  * @param P_FUNCTIONS Unreserved keyword - P_FUNCTIONS
  * @param P_G Unreserved keyword - P_G
  * @param P_GATHER_PLAN_STATISTICS Unreserved keyword - P_GATHER_PLAN_STATISTICS
  * @param P_GBY_CONC_ROLLUP Unreserved keyword - P_GBY_CONC_ROLLUP
  * @param P_GENERATED Unreserved keyword - P_GENERATED
  * @param P_GLOBAL Unreserved keyword - P_GLOBAL
  * @param P_GLOBAL_NAME Unreserved keyword - P_GLOBAL_NAME
  * @param P_GLOBAL_TOPIC_ENABLED Unreserved keyword - P_GLOBAL_TOPIC_ENABLED
  * @param P_GLOBALLY Unreserved keyword - P_GLOBALLY
  * @param P_GROUP_BY Unreserved keyword - P_GROUP_BY
  * @param P_GROUPING Unreserved keyword - P_GROUPING
  * @param P_GROUPS Unreserved keyword - P_GROUPS
  * @param P_GUARANTEE Unreserved keyword - P_GUARANTEE
  * @param P_GUARANTEED Unreserved keyword - P_GUARANTEED
  * @param P_GUARD Unreserved keyword - P_GUARD
  * @param P_HASH Unreserved keyword - P_HASH
  * @param P_HASH_AJ Unreserved keyword - P_HASH_AJ
  * @param P_HASH_SJ Unreserved keyword - P_HASH_SJ
  * @param P_HASHKEYS Unreserved keyword - P_HASHKEYS
  * @param P_HEADER Unreserved keyword - P_HEADER
  * @param P_HEAP Unreserved keyword - P_HEAP
  * @param P_HIERARCHY Unreserved keyword - P_HIERARCHY
  * @param P_HIGH Unreserved keyword - P_HIGH
  * @param P_HINTSET_BEGIN Unreserved keyword - P_HINTSET_BEGIN
  * @param P_HINTSET_END Unreserved keyword - P_HINTSET_END
  * @param P_HOUR Unreserved keyword - P_HOUR
  * @param P_HWM_BROKERED Unreserved keyword - P_HWM_BROKERED
  * @param P_ID Unreserved keyword - P_ID
  * @param P_IDENTIFIER Unreserved keyword - P_IDENTIFIER
  * @param P_IDENTITY Unreserved keyword - P_IDENTITY
  * @param P_IDGENERATORS Unreserved keyword - P_IDGENERATORS
  * @param P_IDLE_TIME Unreserved keyword - P_IDLE_TIME
  * @param P_IF Unreserved keyword - P_IF
  * @param P_IGNORE Unreserved keyword - P_IGNORE
  * @param P_IGNORE_OPTIM_EMBEDDED_HINTS Unreserved keyword - P_IGNORE_OPTIM_EMBEDDED_HINTS
  * @param P_IGNORE_WHERE_CLAUSE Unreserved keyword - P_IGNORE_WHERE_CLAUSE
  * @param P_IMMEDIATE Unreserved keyword - P_IMMEDIATE
  * @param P_IMPORT Unreserved keyword - P_IMPORT
  * @param P_IN_MEMORY_METADATA Unreserved keyword - P_IN_MEMORY_METADATA
  * @param P_INCLUDE_VERSION Unreserved keyword - P_INCLUDE_VERSION
  * @param P_INCLUDING Unreserved keyword - P_INCLUDING
  * @param P_INCREMENT Unreserved keyword - P_INCREMENT
  * @param P_INCREMENTAL Unreserved keyword - P_INCREMENTAL
  * @param P_INDEX_ASC Unreserved keyword - P_INDEX_ASC
  * @param P_INDEX_COMBINE Unreserved keyword - P_INDEX_COMBINE
  * @param P_INDEX_DESC Unreserved keyword - P_INDEX_DESC
  * @param P_INDEX_FFS Unreserved keyword - P_INDEX_FFS
  * @param P_INDEX_FILTER Unreserved keyword - P_INDEX_FILTER
  * @param P_INDEX_JOIN Unreserved keyword - P_INDEX_JOIN
  * @param P_INDEX_ROWS Unreserved keyword - P_INDEX_ROWS
  * @param P_INDEX_RRS Unreserved keyword - P_INDEX_RRS
  * @param P_INDEX_RS Unreserved keyword - P_INDEX_RS
  * @param P_INDEX_RS_ASC Unreserved keyword - P_INDEX_RS_ASC
  * @param P_INDEX_RS_DESC Unreserved keyword - P_INDEX_RS_DESC
  * @param P_INDEX_SCAN Unreserved keyword - P_INDEX_SCAN
  * @param P_INDEX_SKIP_SCAN Unreserved keyword - P_INDEX_SKIP_SCAN
  * @param P_INDEX_SS Unreserved keyword - P_INDEX_SS
  * @param P_INDEX_SS_ASC Unreserved keyword - P_INDEX_SS_ASC
  * @param P_INDEX_SS_DESC Unreserved keyword - P_INDEX_SS_DESC
  * @param P_INDEX_STATS Unreserved keyword - P_INDEX_STATS
  * @param P_INDEXED Unreserved keyword - P_INDEXED
  * @param P_INDEXES Unreserved keyword - P_INDEXES
  * @param P_INDEXTYPE Unreserved keyword - P_INDEXTYPE
  * @param P_INDEXTYPES Unreserved keyword - P_INDEXTYPES
  * @param P_INDICATOR Unreserved keyword - P_INDICATOR
  * @param P_INFINITE Unreserved keyword - P_INFINITE
  * @param P_INFORMATIONAL Unreserved keyword - P_INFORMATIONAL
  * @param P_INITIAL Unreserved keyword - P_INITIAL
  * @param P_INITIALIZED Unreserved keyword - P_INITIALIZED
  * @param P_INITIALLY Unreserved keyword - P_INITIALLY
  * @param P_INITRANS Unreserved keyword - P_INITRANS
  * @param P_INLINE Unreserved keyword - P_INLINE
  * @param P_INLINE_XMLTYPE_NT Unreserved keyword - P_INLINE_XMLTYPE_NT
  * @param P_INNER Unreserved keyword - P_INNER
  * @param P_INSTANCE Unreserved keyword - P_INSTANCE
  * @param P_INSTANCES Unreserved keyword - P_INSTANCES
  * @param P_INSTANTIABLE Unreserved keyword - P_INSTANTIABLE
  * @param P_INSTANTLY Unreserved keyword - P_INSTANTLY
  * @param P_INSTEAD Unreserved keyword - P_INSTEAD
  * @param P_INT Unreserved keyword - P_INT
  * @param P_INTERMEDIATE Unreserved keyword - P_INTERMEDIATE
  * @param P_INTERNAL_CONVERT Unreserved keyword - P_INTERNAL_CONVERT
  * @param P_INTERNAL_USE Unreserved keyword - P_INTERNAL_USE
  * @param P_INTERPRETED Unreserved keyword - P_INTERPRETED
  * @param P_INTERVAL Unreserved keyword - P_INTERVAL
  * @param P_INVALIDATE Unreserved keyword - P_INVALIDATE
  * @param P_ISOLATION Unreserved keyword - P_ISOLATION
  * @param P_ISOLATION_LEVEL Unreserved keyword - P_ISOLATION_LEVEL
  * @param P_ITERATE Unreserved keyword - P_ITERATE
  * @param P_ITERATION_NUMBER Unreserved keyword - P_ITERATION_NUMBER
  * @param P_JAVA Unreserved keyword - P_JAVA
  * @param P_JOB Unreserved keyword - P_JOB
  * @param P_JOIN Unreserved keyword - P_JOIN
  * @param P_K Unreserved keyword - P_K
  * @param P_KEEP Unreserved keyword - P_KEEP
  * @param P_KERBEROS Unreserved keyword - P_KERBEROS
  * @param P_KEY Unreserved keyword - P_KEY
  * @param P_KEY_LENGTH Unreserved keyword - P_KEY_LENGTH
  * @param P_KEYS Unreserved keyword - P_KEYS
  * @param P_KEYSIZE Unreserved keyword - P_KEYSIZE
  * @param P_KILL Unreserved keyword - P_KILL
  * @param P_LAST Unreserved keyword - P_LAST
  * @param P_LATERAL Unreserved keyword - P_LATERAL
  * @param P_LAYER Unreserved keyword - P_LAYER
  * @param P_LDAP_REG_SYNC_INTERVAL Unreserved keyword - P_LDAP_REG_SYNC_INTERVAL
  * @param P_LDAP_REGISTRATION Unreserved keyword - P_LDAP_REGISTRATION
  * @param P_LDAP_REGISTRATION_ENABLED Unreserved keyword - P_LDAP_REGISTRATION_ENABLED
  * @param P_LEADING Unreserved keyword - P_LEADING
  * @param P_LEFT Unreserved keyword - P_LEFT
  * @param P_LENGTH Unreserved keyword - P_LENGTH
  * @param P_LESS Unreserved keyword - P_LESS
  * @param P_LEVEL Unreserved keyword - P_LEVEL
  * @param P_LEVELS Unreserved keyword - P_LEVELS
  * @param P_LIBRARY Unreserved keyword - P_LIBRARY
  * @param P_LIKE_EXPAND Unreserved keyword - P_LIKE_EXPAND
  * @param P_LIKE2 Unreserved keyword - P_LIKE2
  * @param P_LIKE4 Unreserved keyword - P_LIKE4
  * @param P_LIKEC Unreserved keyword - P_LIKEC
  * @param P_LIMIT Unreserved keyword - P_LIMIT
  * @param P_LINK Unreserved keyword - P_LINK
  * @param P_LIST Unreserved keyword - P_LIST
  * @param P_LOB Unreserved keyword - P_LOB
  * @param P_LOCAL Unreserved keyword - P_LOCAL
  * @param P_LOCAL_INDEXES Unreserved keyword - P_LOCAL_INDEXES
  * @param P_LOCALTIME Unreserved keyword - P_LOCALTIME
  * @param P_LOCALTIMESTAMP Unreserved keyword - P_LOCALTIMESTAMP
  * @param P_LOCATION Unreserved keyword - P_LOCATION
  * @param P_LOCATOR Unreserved keyword - P_LOCATOR
  * @param P_LOCKED Unreserved keyword - P_LOCKED
  * @param P_LOG Unreserved keyword - P_LOG
  * @param P_LOGFILE Unreserved keyword - P_LOGFILE
  * @param P_LOGGING Unreserved keyword - P_LOGGING
  * @param P_LOGICAL Unreserved keyword - P_LOGICAL
  * @param P_LOGICAL_READS_PER_CALL Unreserved keyword - P_LOGICAL_READS_PER_CALL
  * @param P_LOGICAL_READS_PER_SESSION Unreserved keyword - P_LOGICAL_READS_PER_SESSION
  * @param P_LOGOFF Unreserved keyword - P_LOGOFF
  * @param P_LOGON Unreserved keyword - P_LOGON
  * @param P_M Unreserved keyword - P_M
  * @param P_MAIN Unreserved keyword - P_MAIN
  * @param P_MANAGE Unreserved keyword - P_MANAGE
  * @param P_MANAGED Unreserved keyword - P_MANAGED
  * @param P_MANAGEMENT Unreserved keyword - P_MANAGEMENT
  * @param P_MANUAL Unreserved keyword - P_MANUAL
  * @param P_MAP Unreserved keyword - P_MAP
  * @param P_MAPPING Unreserved keyword - P_MAPPING
  * @param P_MASTER Unreserved keyword - P_MASTER
  * @param P_MATCHED Unreserved keyword - P_MATCHED
  * @param P_MATERIALIZE Unreserved keyword - P_MATERIALIZE
  * @param P_MATERIALIZED Unreserved keyword - P_MATERIALIZED
  * @param P_MAX Unreserved keyword - P_MAX
  * @param P_MAXARCHLOGS Unreserved keyword - P_MAXARCHLOGS
  * @param P_MAXDATAFILES Unreserved keyword - P_MAXDATAFILES
  * @param P_MAXEXTENTS Unreserved keyword - P_MAXEXTENTS
  * @param P_MAXIMIZE Unreserved keyword - P_MAXIMIZE
  * @param P_MAXINSTANCES Unreserved keyword - P_MAXINSTANCES
  * @param P_MAXLOGFILES Unreserved keyword - P_MAXLOGFILES
  * @param P_MAXLOGHISTORY Unreserved keyword - P_MAXLOGHISTORY
  * @param P_MAXLOGMEMBERS Unreserved keyword - P_MAXLOGMEMBERS
  * @param P_MAXSIZE Unreserved keyword - P_MAXSIZE
  * @param P_MAXTRANS Unreserved keyword - P_MAXTRANS
  * @param P_MAXVALUE Unreserved keyword - P_MAXVALUE
  * @param P_MEASURES Unreserved keyword - P_MEASURES
  * @param P_MEMBER Unreserved keyword - P_MEMBER
  * @param P_MEMORY Unreserved keyword - P_MEMORY
  * @param P_MERGE Unreserved keyword - P_MERGE
  * @param P_MERGE_AJ Unreserved keyword - P_MERGE_AJ
  * @param P_MERGE_CONST_ON Unreserved keyword - P_MERGE_CONST_ON
  * @param P_MERGE_SJ Unreserved keyword - P_MERGE_SJ
  * @param P_METHOD Unreserved keyword - P_METHOD
  * @param P_MIGRATE Unreserved keyword - P_MIGRATE
  * @param P_MIN Unreserved keyword - P_MIN
  * @param P_MINEXTENTS Unreserved keyword - P_MINEXTENTS
  * @param P_MINIMIZE Unreserved keyword - P_MINIMIZE
  * @param P_MINIMUM Unreserved keyword - P_MINIMUM
  * @param P_MINUS_NULL Unreserved keyword - P_MINUS_NULL
  * @param P_MINUTE Unreserved keyword - P_MINUTE
  * @param P_MINVALUE Unreserved keyword - P_MINVALUE
  * @param P_MIRROR Unreserved keyword - P_MIRROR
  * @param P_MLSLABEL Unreserved keyword - P_MLSLABEL
  * @param P_MODEL Unreserved keyword - P_MODEL
  * @param P_MODEL_COMPILE_SUBQUERY Unreserved keyword - P_MODEL_COMPILE_SUBQUERY
  * @param P_MODEL_DONTVERIFY_UNIQUENESS Unreserved keyword - P_MODEL_DONTVERIFY_UNIQUENESS
  * @param P_MODEL_DYNAMIC_SUBQUERY Unreserved keyword - P_MODEL_DYNAMIC_SUBQUERY
  * @param P_MODEL_MIN_ANALYSIS Unreserved keyword - P_MODEL_MIN_ANALYSIS
  * @param P_MODEL_NO_ANALYSIS Unreserved keyword - P_MODEL_NO_ANALYSIS
  * @param P_MODEL_PBY Unreserved keyword - P_MODEL_PBY
  * @param P_MODEL_PUSH_REF Unreserved keyword - P_MODEL_PUSH_REF
  * @param P_MODIFY Unreserved keyword - P_MODIFY
  * @param P_MONITORING Unreserved keyword - P_MONITORING
  * @param P_MONTH Unreserved keyword - P_MONTH
  * @param P_MOUNT Unreserved keyword - P_MOUNT
  * @param P_MOVE Unreserved keyword - P_MOVE
  * @param P_MOVEMENT Unreserved keyword - P_MOVEMENT
  * @param P_MULTISET Unreserved keyword - P_MULTISET
  * @param P_MV_MERGE Unreserved keyword - P_MV_MERGE
  * @param P_NAME Unreserved keyword - P_NAME
  * @param P_NAMED Unreserved keyword - P_NAMED
  * @param P_NAN Unreserved keyword - P_NAN
  * @param P_NATIONAL Unreserved keyword - P_NATIONAL
  * @param P_NATIVE Unreserved keyword - P_NATIVE
  * @param P_NATIVE_FULL_OUTER_JOIN Unreserved keyword - P_NATIVE_FULL_OUTER_JOIN
  * @param P_NATURAL Unreserved keyword - P_NATURAL
  * @param P_NAV Unreserved keyword - P_NAV
  * @param P_NCHAR Unreserved keyword - P_NCHAR
  * @param P_NCHAR_CS Unreserved keyword - P_NCHAR_CS
  * @param P_NCLOB Unreserved keyword - P_NCLOB
  * @param P_NEEDED Unreserved keyword - P_NEEDED
  * @param P_NESTED Unreserved keyword - P_NESTED
  * @param P_NESTED_TABLE_FAST_INSERT Unreserved keyword - P_NESTED_TABLE_FAST_INSERT
  * @param P_NESTED_TABLE_GET_REFS Unreserved keyword - P_NESTED_TABLE_GET_REFS
  * @param P_NESTED_TABLE_ID Unreserved keyword - P_NESTED_TABLE_ID
  * @param P_NESTED_TABLE_SET_REFS Unreserved keyword - P_NESTED_TABLE_SET_REFS
  * @param P_NESTED_TABLE_SET_SETID Unreserved keyword - P_NESTED_TABLE_SET_SETID
  * @param P_NETWORK Unreserved keyword - P_NETWORK
  * @param P_NEVER Unreserved keyword - P_NEVER
  * @param P_NEW Unreserved keyword - P_NEW
  * @param P_NEXT Unreserved keyword - P_NEXT
  * @param P_NL_AJ Unreserved keyword - P_NL_AJ
  * @param P_NL_SJ Unreserved keyword - P_NL_SJ
  * @param P_NLS_CALENDAR Unreserved keyword - P_NLS_CALENDAR
  * @param P_NLS_CHARACTERSET Unreserved keyword - P_NLS_CHARACTERSET
  * @param P_NLS_COMP Unreserved keyword - P_NLS_COMP
  * @param P_NLS_CURRENCY Unreserved keyword - P_NLS_CURRENCY
  * @param P_NLS_DATE_FORMAT Unreserved keyword - P_NLS_DATE_FORMAT
  * @param P_NLS_DATE_LANGUAGE Unreserved keyword - P_NLS_DATE_LANGUAGE
  * @param P_NLS_ISO_CURRENCY Unreserved keyword - P_NLS_ISO_CURRENCY
  * @param P_NLS_LANG Unreserved keyword - P_NLS_LANG
  * @param P_NLS_LANGUAGE Unreserved keyword - P_NLS_LANGUAGE
  * @param P_NLS_LENGTH_SEMANTICS Unreserved keyword - P_NLS_LENGTH_SEMANTICS
  * @param P_NLS_NCHAR_CONV_EXCP Unreserved keyword - P_NLS_NCHAR_CONV_EXCP
  * @param P_NLS_NUMERIC_CHARACTERS Unreserved keyword - P_NLS_NUMERIC_CHARACTERS
  * @param P_NLS_SORT Unreserved keyword - P_NLS_SORT
  * @param P_NLS_SPECIAL_CHARS Unreserved keyword - P_NLS_SPECIAL_CHARS
  * @param P_NLS_TERRITORY Unreserved keyword - P_NLS_TERRITORY
  * @param P_NO Unreserved keyword - P_NO
  * @param P_NO_ACCESS Unreserved keyword - P_NO_ACCESS
  * @param P_NO_BASETABLE_MULTIMV_REWRITE Unreserved keyword - P_NO_BASETABLE_MULTIMV_REWRITE
  * @param P_NO_BUFFER Unreserved keyword - P_NO_BUFFER
  * @param P_NO_CARTESIAN Unreserved keyword - P_NO_CARTESIAN
  * @param P_NO_CONNECT_BY_COST_BASED Unreserved keyword - P_NO_CONNECT_BY_COST_BASED
  * @param P_NO_CONNECT_BY_FILTERING Unreserved keyword - P_NO_CONNECT_BY_FILTERING
  * @param P_NO_CPU_COSTING Unreserved keyword - P_NO_CPU_COSTING
  * @param P_NO_ELIMINATE_JOIN Unreserved keyword - P_NO_ELIMINATE_JOIN
  * @param P_NO_ELIMINATE_OBY Unreserved keyword - P_NO_ELIMINATE_OBY
  * @param P_NO_ELIMINATE_OUTER_JOIN Unreserved keyword - P_NO_ELIMINATE_OUTER_JOIN
  * @param P_NO_EXPAND Unreserved keyword - P_NO_EXPAND
  * @param P_NO_EXPAND_GSET_TO_UNION Unreserved keyword - P_NO_EXPAND_GSET_TO_UNION
  * @param P_NO_FACT Unreserved keyword - P_NO_FACT
  * @param P_NO_FILTERING Unreserved keyword - P_NO_FILTERING
  * @param P_NO_INDEX Unreserved keyword - P_NO_INDEX
  * @param P_NO_INDEX_FFS Unreserved keyword - P_NO_INDEX_FFS
  * @param P_NO_INDEX_RS Unreserved keyword - P_NO_INDEX_RS
  * @param P_NO_INDEX_SS Unreserved keyword - P_NO_INDEX_SS
  * @param P_NO_MERGE Unreserved keyword - P_NO_MERGE
  * @param P_NO_MODEL_PUSH_REF Unreserved keyword - P_NO_MODEL_PUSH_REF
  * @param P_NO_MONITORING Unreserved keyword - P_NO_MONITORING
  * @param P_NO_MULTIMV_REWRITE Unreserved keyword - P_NO_MULTIMV_REWRITE
  * @param P_NO_NATIVE_FULL_OUTER_JOIN Unreserved keyword - P_NO_NATIVE_FULL_OUTER_JOIN
  * @param P_NO_ORDER_ROLLUPS Unreserved keyword - P_NO_ORDER_ROLLUPS
  * @param P_NO_PARALLEL Unreserved keyword - P_NO_PARALLEL
  * @param P_NO_PARALLEL_INDEX Unreserved keyword - P_NO_PARALLEL_INDEX
  * @param P_NO_PARTIAL_COMMIT Unreserved keyword - P_NO_PARTIAL_COMMIT
  * @param P_NO_PRUNE_GSETS Unreserved keyword - P_NO_PRUNE_GSETS
  * @param P_NO_PULL_PRED Unreserved keyword - P_NO_PULL_PRED
  * @param P_NO_PUSH_PRED Unreserved keyword - P_NO_PUSH_PRED
  * @param P_NO_PUSH_SUBQ Unreserved keyword - P_NO_PUSH_SUBQ
  * @param P_NO_PX_JOIN_FILTER Unreserved keyword - P_NO_PX_JOIN_FILTER
  * @param P_NO_QKN_BUFF Unreserved keyword - P_NO_QKN_BUFF
  * @param P_NO_QUERY_TRANSFORMATION Unreserved keyword - P_NO_QUERY_TRANSFORMATION
  * @param P_NO_REF_CASCADE Unreserved keyword - P_NO_REF_CASCADE
  * @param P_NO_REWRITE Unreserved keyword - P_NO_REWRITE
  * @param P_NO_SEMIJOIN Unreserved keyword - P_NO_SEMIJOIN
  * @param P_NO_SET_TO_JOIN Unreserved keyword - P_NO_SET_TO_JOIN
  * @param P_NO_SQL_TUNE Unreserved keyword - P_NO_SQL_TUNE
  * @param P_NO_STAR_TRANSFORMATION Unreserved keyword - P_NO_STAR_TRANSFORMATION
  * @param P_NO_STATS_GSETS Unreserved keyword - P_NO_STATS_GSETS
  * @param P_NO_SWAP_JOIN_INPUTS Unreserved keyword - P_NO_SWAP_JOIN_INPUTS
  * @param P_NO_TEMP_TABLE Unreserved keyword - P_NO_TEMP_TABLE
  * @param P_NO_UNNEST Unreserved keyword - P_NO_UNNEST
  * @param P_NO_USE_HASH Unreserved keyword - P_NO_USE_HASH
  * @param P_NO_USE_HASH_AGGREGATION Unreserved keyword - P_NO_USE_HASH_AGGREGATION
  * @param P_NO_USE_MERGE Unreserved keyword - P_NO_USE_MERGE
  * @param P_NO_USE_NL Unreserved keyword - P_NO_USE_NL
  * @param P_NO_XML_DML_REWRITE Unreserved keyword - P_NO_XML_DML_REWRITE
  * @param P_NO_XML_QUERY_REWRITE Unreserved keyword - P_NO_XML_QUERY_REWRITE
  * @param P_NOAPPEND Unreserved keyword - P_NOAPPEND
  * @param P_NOARCHIVELOG Unreserved keyword - P_NOARCHIVELOG
  * @param P_NOAUDIT Unreserved keyword - P_NOAUDIT
  * @param P_NOCACHE Unreserved keyword - P_NOCACHE
  * @param P_NOCPU_COSTING Unreserved keyword - P_NOCPU_COSTING
  * @param P_NOCYCLE Unreserved keyword - P_NOCYCLE
  * @param P_NODELAY Unreserved keyword - P_NODELAY
  * @param P_NOFORCE Unreserved keyword - P_NOFORCE
  * @param P_NOGUARANTEE Unreserved keyword - P_NOGUARANTEE
  * @param P_NOLOGGING Unreserved keyword - P_NOLOGGING
  * @param P_NOMAPPING Unreserved keyword - P_NOMAPPING
  * @param P_NOMAXVALUE Unreserved keyword - P_NOMAXVALUE
  * @param P_NOMINIMIZE Unreserved keyword - P_NOMINIMIZE
  * @param P_NOMINVALUE Unreserved keyword - P_NOMINVALUE
  * @param P_NOMONITORING Unreserved keyword - P_NOMONITORING
  * @param P_NONE Unreserved keyword - P_NONE
  * @param P_NOORDER Unreserved keyword - P_NOORDER
  * @param P_NOOVERRIDE Unreserved keyword - P_NOOVERRIDE
  * @param P_NOPARALLEL Unreserved keyword - P_NOPARALLEL
  * @param P_NOPARALLEL_INDEX Unreserved keyword - P_NOPARALLEL_INDEX
  * @param P_NORELY Unreserved keyword - P_NORELY
  * @param P_NOREPAIR Unreserved keyword - P_NOREPAIR
  * @param P_NORESETLOGS Unreserved keyword - P_NORESETLOGS
  * @param P_NOREVERSE Unreserved keyword - P_NOREVERSE
  * @param P_NOREWRITE Unreserved keyword - P_NOREWRITE
  * @param P_NORMAL Unreserved keyword - P_NORMAL
  * @param P_NOROWDEPENDENCIES Unreserved keyword - P_NOROWDEPENDENCIES
  * @param P_NOSEGMENT Unreserved keyword - P_NOSEGMENT
  * @param P_NOSORT Unreserved keyword - P_NOSORT
  * @param P_NOSTRICT Unreserved keyword - P_NOSTRICT
  * @param P_NOSWITCH Unreserved keyword - P_NOSWITCH
  * @param P_NOTHING Unreserved keyword - P_NOTHING
  * @param P_NOTIFICATION Unreserved keyword - P_NOTIFICATION
  * @param P_NOVALIDATE Unreserved keyword - P_NOVALIDATE
  * @param P_NULLS Unreserved keyword - P_NULLS
  * @param P_NUM_INDEX_KEYS Unreserved keyword - P_NUM_INDEX_KEYS
  * @param P_NUMERIC Unreserved keyword - P_NUMERIC
  * @param P_NVARCHAR2 Unreserved keyword - P_NVARCHAR2
  * @param P_OBJECT Unreserved keyword - P_OBJECT
  * @param P_OBJNO Unreserved keyword - P_OBJNO
  * @param P_OBJNO_REUSE Unreserved keyword - P_OBJNO_REUSE
  * @param P_OFF Unreserved keyword - P_OFF
  * @param P_OFFLINE Unreserved keyword - P_OFFLINE
  * @param P_OID Unreserved keyword - P_OID
  * @param P_OIDINDEX Unreserved keyword - P_OIDINDEX
  * @param P_OLD Unreserved keyword - P_OLD
  * @param P_OLD_PUSH_PRED Unreserved keyword - P_OLD_PUSH_PRED
  * @param P_ONLINE Unreserved keyword - P_ONLINE
  * @param P_ONLY Unreserved keyword - P_ONLY
  * @param P_OPAQUE Unreserved keyword - P_OPAQUE
  * @param P_OPAQUE_TRANSFORM Unreserved keyword - P_OPAQUE_TRANSFORM
  * @param P_OPAQUE_XCANONICAL Unreserved keyword - P_OPAQUE_XCANONICAL
  * @param P_OPCODE Unreserved keyword - P_OPCODE
  * @param P_OPEN Unreserved keyword - P_OPEN
  * @param P_OPERATOR Unreserved keyword - P_OPERATOR
  * @param P_OPT_ESTIMATE Unreserved keyword - P_OPT_ESTIMATE
  * @param P_OPT_PARAM Unreserved keyword - P_OPT_PARAM
  * @param P_OPTIMAL Unreserved keyword - P_OPTIMAL
  * @param P_OPTIMIZER_FEATURES_ENABLE Unreserved keyword - P_OPTIMIZER_FEATURES_ENABLE
  * @param P_OPTIMIZER_GOAL Unreserved keyword - P_OPTIMIZER_GOAL
  * @param P_OR_EXPAND Unreserved keyword - P_OR_EXPAND
  * @param P_ORA_ROWSCN Unreserved keyword - P_ORA_ROWSCN
  * @param P_ORDERED Unreserved keyword - P_ORDERED
  * @param P_ORDERED_PREDICATES Unreserved keyword - P_ORDERED_PREDICATES
  * @param P_ORDINALITY Unreserved keyword - P_ORDINALITY
  * @param P_ORGANIZATION Unreserved keyword - P_ORGANIZATION
  * @param P_OUT_OF_LINE Unreserved keyword - P_OUT_OF_LINE
  * @param P_OUTER Unreserved keyword - P_OUTER
  * @param P_OUTLINE Unreserved keyword - P_OUTLINE
  * @param P_OUTLINE_LEAF Unreserved keyword - P_OUTLINE_LEAF
  * @param P_OVER Unreserved keyword - P_OVER
  * @param P_OVERFLOW Unreserved keyword - P_OVERFLOW
  * @param P_OVERFLOW_NOMOVE Unreserved keyword - P_OVERFLOW_NOMOVE
  * @param P_OVERLAPS Unreserved keyword - P_OVERLAPS
  * @param P_OVERRIDING Unreserved keyword - P_OVERRIDING
  * @param P_OWN Unreserved keyword - P_OWN
  * @param P_P Unreserved keyword - P_P
  * @param P_PACKAGE Unreserved keyword - P_PACKAGE
  * @param P_PACKAGES Unreserved keyword - P_PACKAGES
  * @param P_PARALLEL Unreserved keyword - P_PARALLEL
  * @param P_PARALLEL_INDEX Unreserved keyword - P_PARALLEL_INDEX
  * @param P_PARAMETERS Unreserved keyword - P_PARAMETERS
  * @param P_PARENT Unreserved keyword - P_PARENT
  * @param P_PARITY Unreserved keyword - P_PARITY
  * @param P_PARTIALLY Unreserved keyword - P_PARTIALLY
  * @param P_PARTITION Unreserved keyword - P_PARTITION
  * @param P_PARTITION_HASH Unreserved keyword - P_PARTITION_HASH
  * @param P_PARTITION_LIST Unreserved keyword - P_PARTITION_LIST
  * @param P_PARTITION_RANGE Unreserved keyword - P_PARTITION_RANGE
  * @param P_PARTITIONS Unreserved keyword - P_PARTITIONS
  * @param P_PASSING Unreserved keyword - P_PASSING
  * @param P_PASSWORD Unreserved keyword - P_PASSWORD
  * @param P_PASSWORD_GRACE_TIME Unreserved keyword - P_PASSWORD_GRACE_TIME
  * @param P_PASSWORD_LIFE_TIME Unreserved keyword - P_PASSWORD_LIFE_TIME
  * @param P_PASSWORD_LOCK_TIME Unreserved keyword - P_PASSWORD_LOCK_TIME
  * @param P_PASSWORD_REUSE_MAX Unreserved keyword - P_PASSWORD_REUSE_MAX
  * @param P_PASSWORD_REUSE_TIME Unreserved keyword - P_PASSWORD_REUSE_TIME
  * @param P_PASSWORD_VERIFY_FUNCTION Unreserved keyword - P_PASSWORD_VERIFY_FUNCTION
  * @param P_PATH Unreserved keyword - P_PATH
  * @param P_PATHS Unreserved keyword - P_PATHS
  * @param P_PCTINCREASE Unreserved keyword - P_PCTINCREASE
  * @param P_PCTTHRESHOLD Unreserved keyword - P_PCTTHRESHOLD
  * @param P_PCTUSED Unreserved keyword - P_PCTUSED
  * @param P_PCTVERSION Unreserved keyword - P_PCTVERSION
  * @param P_PERCENT Unreserved keyword - P_PERCENT
  * @param P_PERFORMANCE Unreserved keyword - P_PERFORMANCE
  * @param P_PERMANENT Unreserved keyword - P_PERMANENT
  * @param P_PFILE Unreserved keyword - P_PFILE
  * @param P_PHYSICAL Unreserved keyword - P_PHYSICAL
  * @param P_PIV_GB Unreserved keyword - P_PIV_GB
  * @param P_PIV_SSF Unreserved keyword - P_PIV_SSF
  * @param P_PLAN Unreserved keyword - P_PLAN
  * @param P_PLSQL_CCFLAGS Unreserved keyword - P_PLSQL_CCFLAGS
  * @param P_PLSQL_CODE_TYPE Unreserved keyword - P_PLSQL_CODE_TYPE
  * @param P_PLSQL_DEBUG Unreserved keyword - P_PLSQL_DEBUG
  * @param P_PLSQL_OPTIMIZE_LEVEL Unreserved keyword - P_PLSQL_OPTIMIZE_LEVEL
  * @param P_PLSQL_WARNINGS Unreserved keyword - P_PLSQL_WARNINGS
  * @param P_POINT Unreserved keyword - P_POINT
  * @param P_POLICY Unreserved keyword - P_POLICY
  * @param P_POST_TRANSACTION Unreserved keyword - P_POST_TRANSACTION
  * @param P_POWER Unreserved keyword - P_POWER
  * @param P_PQ_DISTRIBUTE Unreserved keyword - P_PQ_DISTRIBUTE
  * @param P_PQ_MAP Unreserved keyword - P_PQ_MAP
  * @param P_PQ_NOMAP Unreserved keyword - P_PQ_NOMAP
  * @param P_PREBUILT Unreserved keyword - P_PREBUILT
  * @param P_PRECEDING Unreserved keyword - P_PRECEDING
  * @param P_PRECISION Unreserved keyword - P_PRECISION
  * @param P_PRECOMPUTE_SUBQUERY Unreserved keyword - P_PRECOMPUTE_SUBQUERY
  * @param P_PREPARE Unreserved keyword - P_PREPARE
  * @param P_PRESENT Unreserved keyword - P_PRESENT
  * @param P_PRESERVE Unreserved keyword - P_PRESERVE
  * @param P_PRESERVE_OID Unreserved keyword - P_PRESERVE_OID
  * @param P_PRIMARY Unreserved keyword - P_PRIMARY
  * @param P_PRIVATE Unreserved keyword - P_PRIVATE
  * @param P_PRIVATE_SGA Unreserved keyword - P_PRIVATE_SGA
  * @param P_PRIVILEGE Unreserved keyword - P_PRIVILEGE
  * @param P_PRIVILEGES Unreserved keyword - P_PRIVILEGES
  * @param P_PROCEDURE Unreserved keyword - P_PROCEDURE
  * @param P_PROFILE Unreserved keyword - P_PROFILE
  * @param P_PROGRAM Unreserved keyword - P_PROGRAM
  * @param P_PROJECT Unreserved keyword - P_PROJECT
  * @param P_PROTECTED Unreserved keyword - P_PROTECTED
  * @param P_PROTECTION Unreserved keyword - P_PROTECTION
  * @param P_PULL_PRED Unreserved keyword - P_PULL_PRED
  * @param P_PURGE Unreserved keyword - P_PURGE
  * @param P_PUSH_PRED Unreserved keyword - P_PUSH_PRED
  * @param P_PUSH_SUBQ Unreserved keyword - P_PUSH_SUBQ
  * @param P_PX_GRANULE Unreserved keyword - P_PX_GRANULE
  * @param P_PX_JOIN_FILTER Unreserved keyword - P_PX_JOIN_FILTER
  * @param P_QB_NAME Unreserved keyword - P_QB_NAME
  * @param P_QUERY Unreserved keyword - P_QUERY
  * @param P_QUERY_BLOCK Unreserved keyword - P_QUERY_BLOCK
  * @param P_QUEUE Unreserved keyword - P_QUEUE
  * @param P_QUEUE_CURR Unreserved keyword - P_QUEUE_CURR
  * @param P_QUEUE_ROWP Unreserved keyword - P_QUEUE_ROWP
  * @param P_QUIESCE Unreserved keyword - P_QUIESCE
  * @param P_QUOTA Unreserved keyword - P_QUOTA
  * @param P_RANDOM Unreserved keyword - P_RANDOM
  * @param P_RANGE Unreserved keyword - P_RANGE
  * @param P_RAPIDLY Unreserved keyword - P_RAPIDLY
  * @param P_RBA Unreserved keyword - P_RBA
  * @param P_RBO_OUTLINE Unreserved keyword - P_RBO_OUTLINE
  * @param P_READ Unreserved keyword - P_READ
  * @param P_READS Unreserved keyword - P_READS
  * @param P_REAL Unreserved keyword - P_REAL
  * @param P_REBALANCE Unreserved keyword - P_REBALANCE
  * @param P_REBUILD Unreserved keyword - P_REBUILD
  * @param P_RECORDS_PER_BLOCK Unreserved keyword - P_RECORDS_PER_BLOCK
  * @param P_RECOVER Unreserved keyword - P_RECOVER
  * @param P_RECOVERABLE Unreserved keyword - P_RECOVERABLE
  * @param P_RECOVERY Unreserved keyword - P_RECOVERY
  * @param P_RECYCLE Unreserved keyword - P_RECYCLE
  * @param P_RECYCLEBIN Unreserved keyword - P_RECYCLEBIN
  * @param P_REDUCED Unreserved keyword - P_REDUCED
  * @param P_REDUNDANCY Unreserved keyword - P_REDUNDANCY
  * @param P_REF Unreserved keyword - P_REF
  * @param P_REF_CASCADE_CURSOR Unreserved keyword - P_REF_CASCADE_CURSOR
  * @param P_REFERENCE Unreserved keyword - P_REFERENCE
  * @param P_REFERENCED Unreserved keyword - P_REFERENCED
  * @param P_REFERENCES Unreserved keyword - P_REFERENCES
  * @param P_REFRESH Unreserved keyword - P_REFRESH
  * @param P_REGEXP_LIKE Unreserved keyword - P_REGEXP_LIKE
  * @param P_REGISTER Unreserved keyword - P_REGISTER
  * @param P_REJECT Unreserved keyword - P_REJECT
  * @param P_REKEY Unreserved keyword - P_REKEY
  * @param P_RELATIONAL Unreserved keyword - P_RELATIONAL
  * @param P_RELY Unreserved keyword - P_RELY
  * @param P_REMOTE_MAPPED Unreserved keyword - P_REMOTE_MAPPED
  * @param P_REPAIR Unreserved keyword - P_REPAIR
  * @param P_REPLACE Unreserved keyword - P_REPLACE
  * @param P_REQUIRED Unreserved keyword - P_REQUIRED
  * @param P_RESET Unreserved keyword - P_RESET
  * @param P_RESETLOGS Unreserved keyword - P_RESETLOGS
  * @param P_RESIZE Unreserved keyword - P_RESIZE
  * @param P_RESOLVE Unreserved keyword - P_RESOLVE
  * @param P_RESOLVER Unreserved keyword - P_RESOLVER
  * @param P_RESTORE Unreserved keyword - P_RESTORE
  * @param P_RESTORE_AS_INTERVALS Unreserved keyword - P_RESTORE_AS_INTERVALS
  * @param P_RESTRICT Unreserved keyword - P_RESTRICT
  * @param P_RESTRICT_ALL_REF_CONS Unreserved keyword - P_RESTRICT_ALL_REF_CONS
  * @param P_RESTRICTED Unreserved keyword - P_RESTRICTED
  * @param P_RESUMABLE Unreserved keyword - P_RESUMABLE
  * @param P_RESUME Unreserved keyword - P_RESUME
  * @param P_RETENTION Unreserved keyword - P_RETENTION
  * @param P_RESULT Unreserved keyword - P_RESULT
  * @param P_RETURN Unreserved keyword - P_RETURN
  * @param P_RETURNING Unreserved keyword - P_RETURNING
  * @param P_REUSE Unreserved keyword - P_REUSE
  * @param P_REVERSE Unreserved keyword - P_REVERSE
  * @param P_REWRITE Unreserved keyword - P_REWRITE
  * @param P_REWRITE_OR_ERROR Unreserved keyword - P_REWRITE_OR_ERROR
  * @param P_RIGHT Unreserved keyword - P_RIGHT
  * @param P_ROLE Unreserved keyword - P_ROLE
  * @param P_ROLES Unreserved keyword - P_ROLES
  * @param P_ROLLBACK Unreserved keyword - P_ROLLBACK
  * @param P_ROLLING Unreserved keyword - P_ROLLING
  * @param P_ROLLUP Unreserved keyword - P_ROLLUP
  * @param P_ROW Unreserved keyword - P_ROW
  * @param P_ROW_LENGTH Unreserved keyword - P_ROW_LENGTH
  * @param P_ROWDEPENDENCIES Unreserved keyword - P_ROWDEPENDENCIES
  * @param P_ROWID Unreserved keyword - P_ROWID
  * @param P_ROWNUM Unreserved keyword - P_ROWNUM
  * @param P_ROWS Unreserved keyword - P_ROWS
  * @param P_RULE Unreserved keyword - P_RULE
  * @param P_RULES Unreserved keyword - P_RULES
  * @param P_SALT Unreserved keyword - P_SALT
  * @param P_SAMPLE Unreserved keyword - P_SAMPLE
  * @param P_SAVE_AS_INTERVALS Unreserved keyword - P_SAVE_AS_INTERVALS
  * @param P_SAVEPOINT Unreserved keyword - P_SAVEPOINT
  * @param P_SB4 Unreserved keyword - P_SB4
  * @param P_SCALE Unreserved keyword - P_SCALE
  * @param P_SCALE_ROWS Unreserved keyword - P_SCALE_ROWS
  * @param P_SCAN Unreserved keyword - P_SCAN
  * @param P_SCAN_INSTANCES Unreserved keyword - P_SCAN_INSTANCES
  * @param P_SCHEDULER Unreserved keyword - P_SCHEDULER
  * @param P_SCHEMA Unreserved keyword - P_SCHEMA
  * @param P_SCN Unreserved keyword - P_SCN
  * @param P_SCN_ASCENDING Unreserved keyword - P_SCN_ASCENDING
  * @param P_SCOPE Unreserved keyword - P_SCOPE
  * @param P_SD_ALL Unreserved keyword - P_SD_ALL
  * @param P_SD_INHIBIT Unreserved keyword - P_SD_INHIBIT
  * @param P_SD_SHOW Unreserved keyword - P_SD_SHOW
  * @param P_SECOND Unreserved keyword - P_SECOND
  * @param P_SECURITY Unreserved keyword - P_SECURITY
  * @param P_SEED Unreserved keyword - P_SEED
  * @param P_SEG_BLOCK Unreserved keyword - P_SEG_BLOCK
  * @param P_SEG_FILE Unreserved keyword - P_SEG_FILE
  * @param P_SEGMENT Unreserved keyword - P_SEGMENT
  * @param P_SELECTIVITY Unreserved keyword - P_SELECTIVITY
  * @param P_SEMIJOIN Unreserved keyword - P_SEMIJOIN
  * @param P_SEMIJOIN_DRIVER Unreserved keyword - P_SEMIJOIN_DRIVER
  * @param P_SEQUENCE Unreserved keyword - P_SEQUENCE
  * @param P_SEQUENCED Unreserved keyword - P_SEQUENCED
  * @param P_SEQUENTIAL Unreserved keyword - P_SEQUENTIAL
  * @param P_SERIALIZABLE Unreserved keyword - P_SERIALIZABLE
  * @param P_SERVERERROR Unreserved keyword - P_SERVERERROR
  * @param P_SESSION Unreserved keyword - P_SESSION
  * @param P_SESSION_CACHED_CURSORS Unreserved keyword - P_SESSION_CACHED_CURSORS
  * @param P_SESSIONS_PER_USER Unreserved keyword - P_SESSIONS_PER_USER
  * @param P_SESSIONTIMEZONE Unreserved keyword - P_SESSIONTIMEZONE
  * @param P_SESSIONTZNAME Unreserved keyword - P_SESSIONTZNAME
  * @param P_SET_TO_JOIN Unreserved keyword - P_SET_TO_JOIN
  * @param P_SETS Unreserved keyword - P_SETS
  * @param P_SETTINGS Unreserved keyword - P_SETTINGS
  * @param P_SEVERE Unreserved keyword - P_SEVERE
  * @param P_SHARED Unreserved keyword - P_SHARED
  * @param P_SHARED_POOL Unreserved keyword - P_SHARED_POOL
  * @param P_SHRINK Unreserved keyword - P_SHRINK
  * @param P_SHUTDOWN Unreserved keyword - P_SHUTDOWN
  * @param P_SIBLINGS Unreserved keyword - P_SIBLINGS
  * @param P_SID Unreserved keyword - P_SID
  * @param P_SIMPLE Unreserved keyword - P_SIMPLE
  * @param P_SINGLE Unreserved keyword - P_SINGLE
  * @param P_SINGLETASK Unreserved keyword - P_SINGLETASK
  * @param P_SKIP Unreserved keyword - P_SKIP
  * @param P_SKIP_EXT_OPTIMIZER Unreserved keyword - P_SKIP_EXT_OPTIMIZER
  * @param P_SKIP_UNQ_UNUSABLE_IDX Unreserved keyword - P_SKIP_UNQ_UNUSABLE_IDX
  * @param P_SKIP_UNUSABLE_INDEXES Unreserved keyword - P_SKIP_UNUSABLE_INDEXES
  * @param P_SMALLFILE Unreserved keyword - P_SMALLFILE
  * @param P_SNAPSHOT Unreserved keyword - P_SNAPSHOT
  * @param P_SOME Unreserved keyword - P_SOME
  * @param P_SORT Unreserved keyword - P_SORT
  * @param P_SOURCE Unreserved keyword - P_SOURCE
  * @param P_SPACE Unreserved keyword - P_SPACE
  * @param P_SPECIFICATION Unreserved keyword - P_SPECIFICATION
  * @param P_SPFILE Unreserved keyword - P_SPFILE
  * @param P_SPLIT Unreserved keyword - P_SPLIT
  * @param P_SPREADSHEET Unreserved keyword - P_SPREADSHEET
  * @param P_SQL Unreserved keyword - P_SQL
  * @param P_SQL_TRACE Unreserved keyword - P_SQL_TRACE
  * @param P_SQLLDR Unreserved keyword - P_SQLLDR
  * @param P_STANDALONE Unreserved keyword - P_STANDALONE
  * @param P_STANDBY Unreserved keyword - P_STANDBY
  * @param P_STAR Unreserved keyword - P_STAR
  * @param P_STAR_TRANSFORMATION Unreserved keyword - P_STAR_TRANSFORMATION
  * @param P_STARTUP Unreserved keyword - P_STARTUP
  * @param P_STATEMENT_ID Unreserved keyword - P_STATEMENT_ID
  * @param P_STATIC Unreserved keyword - P_STATIC
  * @param P_STATISTICS Unreserved keyword - P_STATISTICS
  * @param P_STOP Unreserved keyword - P_STOP
  * @param P_STORAGE Unreserved keyword - P_STORAGE
  * @param P_STORE Unreserved keyword - P_STORE
  * @param P_STREAMS Unreserved keyword - P_STREAMS
  * @param P_STRICT Unreserved keyword - P_STRICT
  * @param P_STRING Unreserved keyword - P_STRING
  * @param P_STRIP Unreserved keyword - P_STRIP
  * @param P_STRUCTURE Unreserved keyword - P_STRUCTURE
  * @param P_SUBMULTISET Unreserved keyword - P_SUBMULTISET
  * @param P_SUBPARTITION Unreserved keyword - P_SUBPARTITION
  * @param P_SUBPARTITION_REL Unreserved keyword - P_SUBPARTITION_REL
  * @param P_SUBPARTITIONS Unreserved keyword - P_SUBPARTITIONS
  * @param P_SUBQUERIES Unreserved keyword - P_SUBQUERIES
  * @param P_SUBSTITUTABLE Unreserved keyword - P_SUBSTITUTABLE
  * @param P_SUCCESSFUL Unreserved keyword - P_SUCCESSFUL
  * @param P_SUMMARY Unreserved keyword - P_SUMMARY
  * @param P_SUPPLEMENTAL Unreserved keyword - P_SUPPLEMENTAL
  * @param P_SUSPEND Unreserved keyword - P_SUSPEND
  * @param P_SWAP_JOIN_INPUTS Unreserved keyword - P_SWAP_JOIN_INPUTS
  * @param P_SWITCH Unreserved keyword - P_SWITCH
  * @param P_SWITCHOVER Unreserved keyword - P_SWITCHOVER
  * @param P_SYS_DL_CURSOR Unreserved keyword - P_SYS_DL_CURSOR
  * @param P_SYS_FBT_INSDEL Unreserved keyword - P_SYS_FBT_INSDEL
  * @param P_SYS_OP_BITVEC Unreserved keyword - P_SYS_OP_BITVEC
  * @param P_SYS_OP_CAST Unreserved keyword - P_SYS_OP_CAST
  * @param P_SYS_OP_ENFORCE_NOT_NULL$ Unreserved keyword - P_SYS_OP_ENFORCE_NOT_NULL$
  * @param P_SYS_OP_EXTRACT Unreserved keyword - P_SYS_OP_EXTRACT
  * @param P_SYS_OP_NOEXPAND Unreserved keyword - P_SYS_OP_NOEXPAND
  * @param P_SYS_OP_NTCIMG$ Unreserved keyword - P_SYS_OP_NTCIMG$
  * @param P_SYS_PARALLEL_TXN Unreserved keyword - P_SYS_PARALLEL_TXN
  * @param P_SYS_RID_ORDER Unreserved keyword - P_SYS_RID_ORDER
  * @param P_SYSAUX Unreserved keyword - P_SYSAUX
  * @param P_SYSDATE Unreserved keyword - P_SYSDATE
  * @param P_SYSDBA Unreserved keyword - P_SYSDBA
  * @param P_SYSOPER Unreserved keyword - P_SYSOPER
  * @param P_SYSTEM Unreserved keyword - P_SYSTEM
  * @param P_SYSTIMESTAMP Unreserved keyword - P_SYSTIMESTAMP
  * @param P_T Unreserved keyword - P_T
  * @param P_TABLE_STATS Unreserved keyword - P_TABLE_STATS
  * @param P_TABLES Unreserved keyword - P_TABLES
  * @param P_TABLESPACE Unreserved keyword - P_TABLESPACE
  * @param P_TABLESPACE_NO Unreserved keyword - P_TABLESPACE_NO
  * @param P_TABNO Unreserved keyword - P_TABNO
  * @param P_TEMP_TABLE Unreserved keyword - P_TEMP_TABLE
  * @param P_TEMPFILE Unreserved keyword - P_TEMPFILE
  * @param P_TEMPLATE Unreserved keyword - P_TEMPLATE
  * @param P_TEMPORARY Unreserved keyword - P_TEMPORARY
  * @param P_TEST Unreserved keyword - P_TEST
  * @param P_THAN Unreserved keyword - P_THAN
  * @param P_THE Unreserved keyword - P_THE
  * @param P_THREAD Unreserved keyword - P_THREAD
  * @param P_THROUGH Unreserved keyword - P_THROUGH
  * @param P_TIME Unreserved keyword - P_TIME
  * @param P_TIME_ZONE Unreserved keyword - P_TIME_ZONE
  * @param P_TIMEOUT Unreserved keyword - P_TIMEOUT
  * @param P_TIMESTAMP Unreserved keyword - P_TIMESTAMP
  * @param P_TIMEZONE_ABBR Unreserved keyword - P_TIMEZONE_ABBR
  * @param P_TIMEZONE_HOUR Unreserved keyword - P_TIMEZONE_HOUR
  * @param P_TIMEZONE_MINUTE Unreserved keyword - P_TIMEZONE_MINUTE
  * @param P_TIMEZONE_OFFSET Unreserved keyword - P_TIMEZONE_OFFSET
  * @param P_TIMEZONE_REGION Unreserved keyword - P_TIMEZONE_REGION
  * @param P_TIV_GB Unreserved keyword - P_TIV_GB
  * @param P_TIV_SSF Unreserved keyword - P_TIV_SSF
  * @param P_TO_CHAR Unreserved keyword - P_TO_CHAR
  * @param P_TOPLEVEL Unreserved keyword - P_TOPLEVEL
  * @param P_TRACE Unreserved keyword - P_TRACE
  * @param P_TRACING Unreserved keyword - P_TRACING
  * @param P_TRACKING Unreserved keyword - P_TRACKING
  * @param P_TRAILING Unreserved keyword - P_TRAILING
  * @param P_TRANSACTION Unreserved keyword - P_TRANSACTION
  * @param P_TRANSITIONAL Unreserved keyword - P_TRANSITIONAL
  * @param P_TREAT Unreserved keyword - P_TREAT
  * @param P_TRIGGERS Unreserved keyword - P_TRIGGERS
  * @param P_TRUE Unreserved keyword - P_TRUE
  * @param P_TRUNCATE Unreserved keyword - P_TRUNCATE
  * @param P_TRUSTED Unreserved keyword - P_TRUSTED
  * @param P_TUNING Unreserved keyword - P_TUNING
  * @param P_TX Unreserved keyword - P_TX
  * @param P_TYPE Unreserved keyword - P_TYPE
  * @param P_TYPES Unreserved keyword - P_TYPES
  * @param P_TZ_OFFSET Unreserved keyword - P_TZ_OFFSET
  * @param P_U Unreserved keyword - P_U
  * @param P_UB2 Unreserved keyword - P_UB2
  * @param P_UBA Unreserved keyword - P_UBA
  * @param P_UID Unreserved keyword - P_UID
  * @param P_UNARCHIVED Unreserved keyword - P_UNARCHIVED
  * @param P_UNBOUND Unreserved keyword - P_UNBOUND
  * @param P_UNBOUNDED Unreserved keyword - P_UNBOUNDED
  * @param P_UNDER Unreserved keyword - P_UNDER
  * @param P_UNDO Unreserved keyword - P_UNDO
  * @param P_UNDROP Unreserved keyword - P_UNDROP
  * @param P_UNIFORM Unreserved keyword - P_UNIFORM
  * @param P_UNLIMITED Unreserved keyword - P_UNLIMITED
  * @param P_UNLOCK Unreserved keyword - P_UNLOCK
  * @param P_UNNEST Unreserved keyword - P_UNNEST
  * @param P_UNPACKED Unreserved keyword - P_UNPACKED
  * @param P_UNPROTECTED Unreserved keyword - P_UNPROTECTED
  * @param P_UNQUIESCE Unreserved keyword - P_UNQUIESCE
  * @param P_UNRECOVERABLE Unreserved keyword - P_UNRECOVERABLE
  * @param P_UNTIL Unreserved keyword - P_UNTIL
  * @param P_UNUSABLE Unreserved keyword - P_UNUSABLE
  * @param P_UNUSED Unreserved keyword - P_UNUSED
  * @param P_UPD_INDEXES Unreserved keyword - P_UPD_INDEXES
  * @param P_UPD_JOININDEX Unreserved keyword - P_UPD_JOININDEX
  * @param P_UPDATABLE Unreserved keyword - P_UPDATABLE
  * @param P_UPDATED Unreserved keyword - P_UPDATED
  * @param P_UPGRADE Unreserved keyword - P_UPGRADE
  * @param P_UPSERT Unreserved keyword - P_UPSERT
  * @param P_UROWID Unreserved keyword - P_UROWID
  * @param P_USAGE Unreserved keyword - P_USAGE
  * @param P_USE Unreserved keyword - P_USE
  * @param P_USE_ANTI Unreserved keyword - P_USE_ANTI
  * @param P_USE_CONCAT Unreserved keyword - P_USE_CONCAT
  * @param P_USE_HASH Unreserved keyword - P_USE_HASH
  * @param P_USE_HASH_AGGREGATION Unreserved keyword - P_USE_HASH_AGGREGATION
  * @param P_USE_MERGE Unreserved keyword - P_USE_MERGE
  * @param P_USE_NL Unreserved keyword - P_USE_NL
  * @param P_USE_NL_WITH_INDEX Unreserved keyword - P_USE_NL_WITH_INDEX
  * @param P_USE_PRIVATE_OUTLINES Unreserved keyword - P_USE_PRIVATE_OUTLINES
  * @param P_USE_SEMI Unreserved keyword - P_USE_SEMI
  * @param P_USE_STORED_OUTLINES Unreserved keyword - P_USE_STORED_OUTLINES
  * @param P_USE_TTT_FOR_GSETS Unreserved keyword - P_USE_TTT_FOR_GSETS
  * @param P_USE_WEAK_NAME_RESL Unreserved keyword - P_USE_WEAK_NAME_RESL
  * @param P_USER Unreserved keyword - P_USER
  * @param P_USER_DEFINED Unreserved keyword - P_USER_DEFINED
  * @param P_USER_RECYCLEBIN Unreserved keyword - P_USER_RECYCLEBIN
  * @param P_USERS Unreserved keyword - P_USERS
  * @param P_USING Unreserved keyword - P_USING
  * @param P_VALIDATE Unreserved keyword - P_VALIDATE
  * @param P_VALIDATION Unreserved keyword - P_VALIDATION
  * @param P_VALUE Unreserved keyword - P_VALUE
  * @param P_VARCHAR Unreserved keyword - P_VARCHAR
  * @param P_VARCHAR2 Unreserved keyword - P_VARCHAR2
  * @param P_VARRAY Unreserved keyword - P_VARRAY
  * @param P_VARYING Unreserved keyword - P_VARYING
  * @param P_VECTOR_READ Unreserved keyword - P_VECTOR_READ
  * @param P_VECTOR_READ_TRACE Unreserved keyword - P_VECTOR_READ_TRACE
  * @param P_VERSION Unreserved keyword - P_VERSION
  * @param P_VERSIONS Unreserved keyword - P_VERSIONS
  * @param P_WAIT Unreserved keyword - P_WAIT
  * @param P_WALLET Unreserved keyword - P_WALLET
  * @param P_WELLFORMED Unreserved keyword - P_WELLFORMED
  * @param P_WHEN Unreserved keyword - P_WHEN
  * @param P_WHENEVER Unreserved keyword - P_WHENEVER
  * @param P_WHITESPACE Unreserved keyword - P_WHITESPACE
  * @param P_WITHIN Unreserved keyword - P_WITHIN
  * @param P_WITHOUT Unreserved keyword - P_WITHOUT
  * @param P_WORK Unreserved keyword - P_WORK
  * @param P_WRAPPED Unreserved keyword - P_WRAPPED
  * @param P_WRITE Unreserved keyword - P_WRITE
  * @param P_X_DYN_PRUNE Unreserved keyword - P_X_DYN_PRUNE
  * @param P_XID Unreserved keyword - P_XID
  * @param P_XML_DML_RWT_STMT Unreserved keyword - P_XML_DML_RWT_STMT
  * @param P_XMLATTRIBUTES Unreserved keyword - P_XMLATTRIBUTES
  * @param P_XMLCOLATTVAL Unreserved keyword - P_XMLCOLATTVAL
  * @param P_XMLELEMENT Unreserved keyword - P_XMLELEMENT
  * @param P_XMLFOREST Unreserved keyword - P_XMLFOREST
  * @param P_XMLNAMESPACES Unreserved keyword - P_XMLNAMESPACES
  * @param P_XMLPARSE Unreserved keyword - P_XMLPARSE
  * @param P_XMLPI Unreserved keyword - P_XMLPI
  * @param P_XMLQUERY Unreserved keyword - P_XMLQUERY
  * @param P_XMLROOT Unreserved keyword - P_XMLROOT
  * @param P_XMLSCHEMA Unreserved keyword - P_XMLSCHEMA
  * @param P_XMLSERIALIZE Unreserved keyword - P_XMLSERIALIZE
  * @param P_XMLTABLE Unreserved keyword - P_XMLTABLE
  * @param P_XMLTYPE Unreserved keyword - P_XMLTYPE
  * @param P_YEAR Unreserved keyword - P_YEAR
  * @param P_YES Unreserved keyword - P_YES
  * @param P_ZONE Unreserved keyword - P_ZONE
  */
  (P_A VARCHAR2
  ,P_ABORT VARCHAR2
  ,P_ACCESS VARCHAR2
  ,P_ACCESSED VARCHAR2
  ,P_ACCOUNT VARCHAR2
  ,P_ACTIVATE VARCHAR2
  ,P_ADD VARCHAR2
  ,P_ADMIN VARCHAR2
  ,P_ADMINISTER VARCHAR2
  ,P_ADMINISTRATOR VARCHAR2
  ,P_ADVISE VARCHAR2
  ,P_ADVISOR VARCHAR2
  ,P_AFTER VARCHAR2
  ,P_AGGREGATE VARCHAR2
  ,P_ALIAS VARCHAR2
  ,P_ALL_ROWS VARCHAR2
  ,P_ALLOCATE VARCHAR2
  ,P_ALLOW VARCHAR2
  ,P_ALWAYS VARCHAR2
  ,P_ANALYZE VARCHAR2
  ,P_ANCILLARY VARCHAR2
  ,P_AND_EQUAL VARCHAR2
  ,P_ANTIJOIN VARCHAR2
  ,P_APPEND VARCHAR2
  ,P_APPLY VARCHAR2
  ,P_ARCHIVE VARCHAR2
  ,P_ARCHIVELOG VARCHAR2
  ,P_ARRAY VARCHAR2
  ,P_ASSOCIATE VARCHAR2
  ,P_AT VARCHAR2
  ,P_ATTRIBUTE VARCHAR2
  ,P_ATTRIBUTES VARCHAR2
  ,P_AUDIT VARCHAR2
  ,P_AUTHENTICATED VARCHAR2
  ,P_AUTHENTICATION VARCHAR2
  ,P_AUTHID VARCHAR2
  ,P_AUTHORIZATION VARCHAR2
  ,P_AUTO VARCHAR2
  ,P_AUTOALLOCATE VARCHAR2
  ,P_AUTOEXTEND VARCHAR2
  ,P_AUTOMATIC VARCHAR2
  ,P_AVAILABILITY VARCHAR2
  ,P_BACKUP VARCHAR2
  ,P_BATCH VARCHAR2
  ,P_BECOME VARCHAR2
  ,P_BEFORE VARCHAR2
  ,P_BEGIN VARCHAR2
  ,P_BEGIN_OUTLINE_DATA VARCHAR2
  ,P_BEHALF VARCHAR2
  ,P_BFILE VARCHAR2
  ,P_BIGFILE VARCHAR2
  ,P_BINARY_DOUBLE VARCHAR2
  ,P_BINARY_DOUBLE_INFINITY VARCHAR2
  ,P_BINARY_DOUBLE_NAN VARCHAR2
  ,P_BINARY_FLOAT VARCHAR2
  ,P_BINARY_FLOAT_INFINITY VARCHAR2
  ,P_BINARY_FLOAT_NAN VARCHAR2
  ,P_BINDING VARCHAR2
  ,P_BITMAP VARCHAR2
  ,P_BITMAP_TREE VARCHAR2
  ,P_BITMAPS VARCHAR2
  ,P_BITS VARCHAR2
  ,P_BLOB VARCHAR2
  ,P_BLOCK VARCHAR2
  ,P_BLOCK_RANGE VARCHAR2
  ,P_BLOCKS VARCHAR2
  ,P_BLOCKSIZE VARCHAR2
  ,P_BODY VARCHAR2
  ,P_BOTH VARCHAR2
  ,P_BOUND VARCHAR2
  ,P_BROADCAST VARCHAR2
  ,P_BUFFER VARCHAR2
  ,P_BUFFER_CACHE VARCHAR2
  ,P_BUFFER_POOL VARCHAR2
  ,P_BUILD VARCHAR2
  ,P_BULK VARCHAR2
  ,P_BYPASS_RECURSIVE_CHECK VARCHAR2
  ,P_BYPASS_UJVC VARCHAR2
  ,P_BY VARCHAR2
  ,P_BYTE VARCHAR2
  ,P_CACHE VARCHAR2
  ,P_CACHE_CB VARCHAR2
  ,P_CACHE_INSTANCES VARCHAR2
  ,P_CACHE_TEMP_TABLE VARCHAR2
  ,P_CALL VARCHAR2
  ,P_CANCEL VARCHAR2
  ,P_CARDINALITY VARCHAR2
  ,P_CASCADE VARCHAR2
  ,P_CASE VARCHAR2
  ,P_CAST VARCHAR2
  ,P_CATEGORY VARCHAR2
  ,P_CERTIFICATE VARCHAR2
  ,P_CFILE VARCHAR2
  ,P_CHAINED VARCHAR2
  ,P_CHANGE VARCHAR2
  ,P_CHAR_CS VARCHAR2
  ,P_CHARACTER VARCHAR2
  ,P_CHECKPOINT VARCHAR2
  ,P_CHILD VARCHAR2
  ,P_CHOOSE VARCHAR2
  ,P_CHUNK VARCHAR2
  ,P_CIV_GB VARCHAR2
  ,P_CLASS VARCHAR2
  ,P_CLEAR VARCHAR2
  ,P_CLOB VARCHAR2
  ,P_CLONE VARCHAR2
  ,P_CLOSE VARCHAR2
  ,P_CLOSE_CACHED_OPEN_CURSORS VARCHAR2
  ,P_CLUSTERING_FACTOR VARCHAR2
  ,P_COALESCE VARCHAR2
  ,P_COARSE VARCHAR2
  ,P_COLLECT VARCHAR2
  ,P_COLUMN VARCHAR2
  ,P_COLUMN_STATS VARCHAR2
  ,P_COLUMN_VALUE VARCHAR2
  ,P_COLUMNS VARCHAR2
  ,P_COMMENT VARCHAR2
  ,P_COMMIT VARCHAR2
  ,P_COMMITTED VARCHAR2
  ,P_COMPACT VARCHAR2
  ,P_COMPATIBILITY VARCHAR2
  ,P_COMPILE VARCHAR2
  ,P_COMPLETE VARCHAR2
  ,P_COMPOSITE_LIMIT VARCHAR2
  ,P_COMPUTE VARCHAR2
  ,P_CONFORMING VARCHAR2
  ,P_CONNECT_BY_COST_BASED VARCHAR2
  ,P_CONNECT_BY_FILTERING VARCHAR2
  ,P_CONNECT_BY_ISCYCLE VARCHAR2
  ,P_CONNECT_BY_ISLEAF VARCHAR2
  ,P_CONNECT_BY_ROOT VARCHAR2
  ,P_CONNECT_TIME VARCHAR2
  ,P_CONSIDER VARCHAR2
  ,P_CONSISTENT VARCHAR2
  ,P_CONSTRAINT VARCHAR2
  ,P_CONSTRAINTS VARCHAR2
  ,P_CONTAINER VARCHAR2
  ,P_CONTENT VARCHAR2
  ,P_CONTENTS VARCHAR2
  ,P_CONTEXT VARCHAR2
  ,P_CONTINUE VARCHAR2
  ,P_CONTROLFILE VARCHAR2
  ,P_CONVERT VARCHAR2
  ,P_CORRUPTION VARCHAR2
  ,P_COST VARCHAR2
  ,P_CPU_COSTING VARCHAR2
  ,P_CPU_PER_CALL VARCHAR2
  ,P_CPU_PER_SESSION VARCHAR2
  ,P_CREATE_STORED_OUTLINES VARCHAR2
  ,P_CROSS VARCHAR2
  ,P_CUBE VARCHAR2
  ,P_CUBE_GB VARCHAR2
  ,P_CURRENT VARCHAR2
  ,P_CURRENT_DATE VARCHAR2
  ,P_CURRENT_SCHEMA VARCHAR2
  ,P_CURRENT_TIME VARCHAR2
  ,P_CURRENT_TIMESTAMP VARCHAR2
  ,P_CURRENT_USER VARCHAR2
  ,P_CURSOR VARCHAR2
  ,P_CURSOR_SHARING_EXACT VARCHAR2
  ,P_CURSOR_SPECIFIC_SEGMENT VARCHAR2
  ,P_CYCLE VARCHAR2
  ,P_DANGLING VARCHAR2
  ,P_DATA VARCHAR2
  ,P_DATABASE VARCHAR2
  ,P_DATAFILE VARCHAR2
  ,P_DATAFILES VARCHAR2
  ,P_DATAOBJNO VARCHAR2
  ,P_DATE_MODE VARCHAR2
  ,P_DAY VARCHAR2
  ,P_DB_ROLE_CHANGE VARCHAR2
  ,P_DBA VARCHAR2
  ,P_DBA_RECYCLEBIN VARCHAR2
  ,P_DBMS_STATS VARCHAR2
  ,P_DBTIMEZONE VARCHAR2
  ,P_DDL VARCHAR2
  ,P_DEALLOCATE VARCHAR2
  ,P_DEBUG VARCHAR2
  ,P_DEC VARCHAR2
  ,P_DECLARE VARCHAR2
  ,P_DECREMENT VARCHAR2
  ,P_DECRYPT VARCHAR2
  ,P_DEFERRABLE VARCHAR2
  ,P_DEFERRED VARCHAR2
  ,P_DEFINED VARCHAR2
  ,P_DEFINER VARCHAR2
  ,P_DEGREE VARCHAR2
  ,P_DELAY VARCHAR2
  ,P_DEMAND VARCHAR2
  ,P_DENSE_RANK VARCHAR2
  ,P_DEQUEUE VARCHAR2
  ,P_DEREF VARCHAR2
  ,P_DEREF_NO_REWRITE VARCHAR2
  ,P_DETACHED VARCHAR2
  ,P_DETERMINES VARCHAR2
  ,P_DICTIONARY VARCHAR2
  ,P_DIMENSION VARCHAR2
  ,P_DIRECTORY VARCHAR2
  ,P_DISABLE VARCHAR2
  ,P_DISABLE_RPKE VARCHAR2
  ,P_DISASSOCIATE VARCHAR2
  ,P_DISCONNECT VARCHAR2
  ,P_DISK VARCHAR2
  ,P_DISKGROUP VARCHAR2
  ,P_DISKS VARCHAR2
  ,P_DISMOUNT VARCHAR2
  ,P_DISTINGUISHED VARCHAR2
  ,P_DISTRIBUTED VARCHAR2
  ,P_DML VARCHAR2
  ,P_DML_UPDATE VARCHAR2
  ,P_DOCUMENT VARCHAR2
  ,P_DOMAIN_INDEX_NO_SORT VARCHAR2
  ,P_DOMAIN_INDEX_SORT VARCHAR2
  ,P_DOUBLE VARCHAR2
  ,P_DOWNGRADE VARCHAR2
  ,P_DRIVING_SITE VARCHAR2
  ,P_DUMP VARCHAR2
  ,P_DYNAMIC VARCHAR2
  ,P_DYNAMIC_SAMPLING VARCHAR2
  ,P_DYNAMIC_SAMPLING_EST_CDN VARCHAR2
  ,P_E VARCHAR2
  ,P_EACH VARCHAR2
  ,P_ELEMENT VARCHAR2
  ,P_ELIMINATE_JOIN VARCHAR2
  ,P_ELIMINATE_OBY VARCHAR2
  ,P_ELIMINATE_OUTER_JOIN VARCHAR2
  ,P_EMPTY VARCHAR2
  ,P_ENABLE VARCHAR2
  ,P_ENCRYPT VARCHAR2
  ,P_ENCRYPTION VARCHAR2
  ,P_END VARCHAR2
  ,P_END_OUTLINE_DATA VARCHAR2
  ,P_ENFORCE VARCHAR2
  ,P_ENFORCED VARCHAR2
  ,P_ENQUEUE VARCHAR2
  ,P_ENTERPRISE VARCHAR2
  ,P_ENTRY VARCHAR2
  ,P_ERROR VARCHAR2
  ,P_ERROR_ON_OVERLAP_TIME VARCHAR2
  ,P_ERRORS VARCHAR2
  ,P_ESCAPE VARCHAR2
  ,P_ESTIMATE VARCHAR2
  ,P_EVALNAME VARCHAR2
  ,P_EVALUATION VARCHAR2
  ,P_EVENTS VARCHAR2
  ,P_EXCEPT VARCHAR2
  ,P_EXCEPTIONS VARCHAR2
  ,P_EXCHANGE VARCHAR2
  ,P_EXCLUDING VARCHAR2
  ,P_EXECUTE VARCHAR2
  ,P_EXEMPT VARCHAR2
  ,P_EXPAND_GSET_TO_UNION VARCHAR2
  ,P_EXPIRE VARCHAR2
  ,P_EXPLAIN VARCHAR2
  ,P_EXPLOSION VARCHAR2
  ,P_EXPORT VARCHAR2
  ,P_EXPR_CORR_CHECK VARCHAR2
  ,P_EXTENDS VARCHAR2
  ,P_EXTENT VARCHAR2
  ,P_EXTENTS VARCHAR2
  ,P_EXTERNAL VARCHAR2
  ,P_EXTERNALLY VARCHAR2
  ,P_EXTRACT VARCHAR2
  ,P_FACT VARCHAR2
  ,P_FAILED VARCHAR2
  ,P_FAILED_LOGIN_ATTEMPTS VARCHAR2
  ,P_FAILGROUP VARCHAR2
  ,P_FALSE VARCHAR2
  ,P_FAST VARCHAR2
  ,P_FBTSCAN VARCHAR2
  ,P_FIC_CIV VARCHAR2
  ,P_FIC_PIV VARCHAR2
  ,P_FILE VARCHAR2
  ,P_FILTER VARCHAR2
  ,P_FINAL VARCHAR2
  ,P_FINE VARCHAR2
  ,P_FINISH VARCHAR2
  ,P_FIRST VARCHAR2
  ,P_FIRST_ROWS VARCHAR2
  ,P_FLAGGER VARCHAR2
  ,P_FLASHBACK VARCHAR2
  ,P_FLOB VARCHAR2
  ,P_FLUSH VARCHAR2
  ,P_FOLLOWING VARCHAR2
  ,P_FORCE VARCHAR2
  ,P_FORCE_XML_QUERY_REWRITE VARCHAR2
  ,P_FOREIGN VARCHAR2
  ,P_FREELIST VARCHAR2
  ,P_FREELISTS VARCHAR2
  ,P_FREEPOOLS VARCHAR2
  ,P_FRESH VARCHAR2
  ,P_FULL VARCHAR2
  ,P_FUNCTION VARCHAR2
  ,P_FUNCTIONS VARCHAR2
  ,P_G VARCHAR2
  ,P_GATHER_PLAN_STATISTICS VARCHAR2
  ,P_GBY_CONC_ROLLUP VARCHAR2
  ,P_GENERATED VARCHAR2
  ,P_GLOBAL VARCHAR2
  ,P_GLOBAL_NAME VARCHAR2
  ,P_GLOBAL_TOPIC_ENABLED VARCHAR2
  ,P_GLOBALLY VARCHAR2
  ,P_GROUP_BY VARCHAR2
  ,P_GROUPING VARCHAR2
  ,P_GROUPS VARCHAR2
  ,P_GUARANTEE VARCHAR2
  ,P_GUARANTEED VARCHAR2
  ,P_GUARD VARCHAR2
  ,P_HASH VARCHAR2
  ,P_HASH_AJ VARCHAR2
  ,P_HASH_SJ VARCHAR2
  ,P_HASHKEYS VARCHAR2
  ,P_HEADER VARCHAR2
  ,P_HEAP VARCHAR2
  ,P_HIERARCHY VARCHAR2
  ,P_HIGH VARCHAR2
  ,P_HINTSET_BEGIN VARCHAR2
  ,P_HINTSET_END VARCHAR2
  ,P_HOUR VARCHAR2
  ,P_HWM_BROKERED VARCHAR2
  ,P_ID VARCHAR2
  ,P_IDENTIFIER VARCHAR2
  ,P_IDENTITY VARCHAR2
  ,P_IDGENERATORS VARCHAR2
  ,P_IDLE_TIME VARCHAR2
  ,P_IF VARCHAR2
  ,P_IGNORE VARCHAR2
  ,P_IGNORE_OPTIM_EMBEDDED_HINTS VARCHAR2
  ,P_IGNORE_WHERE_CLAUSE VARCHAR2
  ,P_IMMEDIATE VARCHAR2
  ,P_IMPORT VARCHAR2
  ,P_IN_MEMORY_METADATA VARCHAR2
  ,P_INCLUDE_VERSION VARCHAR2
  ,P_INCLUDING VARCHAR2
  ,P_INCREMENT VARCHAR2
  ,P_INCREMENTAL VARCHAR2
  ,P_INDEX_ASC VARCHAR2
  ,P_INDEX_COMBINE VARCHAR2
  ,P_INDEX_DESC VARCHAR2
  ,P_INDEX_FFS VARCHAR2
  ,P_INDEX_FILTER VARCHAR2
  ,P_INDEX_JOIN VARCHAR2
  ,P_INDEX_ROWS VARCHAR2
  ,P_INDEX_RRS VARCHAR2
  ,P_INDEX_RS VARCHAR2
  ,P_INDEX_RS_ASC VARCHAR2
  ,P_INDEX_RS_DESC VARCHAR2
  ,P_INDEX_SCAN VARCHAR2
  ,P_INDEX_SKIP_SCAN VARCHAR2
  ,P_INDEX_SS VARCHAR2
  ,P_INDEX_SS_ASC VARCHAR2
  ,P_INDEX_SS_DESC VARCHAR2
  ,P_INDEX_STATS VARCHAR2
  ,P_INDEXED VARCHAR2
  ,P_INDEXES VARCHAR2
  ,P_INDEXTYPE VARCHAR2
  ,P_INDEXTYPES VARCHAR2
  ,P_INDICATOR VARCHAR2
  ,P_INFINITE VARCHAR2
  ,P_INFORMATIONAL VARCHAR2
  ,P_INITIAL VARCHAR2
  ,P_INITIALIZED VARCHAR2
  ,P_INITIALLY VARCHAR2
  ,P_INITRANS VARCHAR2
  ,P_INLINE VARCHAR2
  ,P_INLINE_XMLTYPE_NT VARCHAR2
  ,P_INNER VARCHAR2
  ,P_INSTANCE VARCHAR2
  ,P_INSTANCES VARCHAR2
  ,P_INSTANTIABLE VARCHAR2
  ,P_INSTANTLY VARCHAR2
  ,P_INSTEAD VARCHAR2
  ,P_INT VARCHAR2
  ,P_INTERMEDIATE VARCHAR2
  ,P_INTERNAL_CONVERT VARCHAR2
  ,P_INTERNAL_USE VARCHAR2
  ,P_INTERPRETED VARCHAR2
  ,P_INTERVAL VARCHAR2
  ,P_INVALIDATE VARCHAR2
  ,P_ISOLATION VARCHAR2
  ,P_ISOLATION_LEVEL VARCHAR2
  ,P_ITERATE VARCHAR2
  ,P_ITERATION_NUMBER VARCHAR2
  ,P_JAVA VARCHAR2
  ,P_JOB VARCHAR2
  ,P_JOIN VARCHAR2
  ,P_K VARCHAR2
  ,P_KEEP VARCHAR2
  ,P_KERBEROS VARCHAR2
  ,P_KEY VARCHAR2
  ,P_KEY_LENGTH VARCHAR2
  ,P_KEYS VARCHAR2
  ,P_KEYSIZE VARCHAR2
  ,P_KILL VARCHAR2
  ,P_LAST VARCHAR2
  ,P_LATERAL VARCHAR2
  ,P_LAYER VARCHAR2
  ,P_LDAP_REG_SYNC_INTERVAL VARCHAR2
  ,P_LDAP_REGISTRATION VARCHAR2
  ,P_LDAP_REGISTRATION_ENABLED VARCHAR2
  ,P_LEADING VARCHAR2
  ,P_LEFT VARCHAR2
  ,P_LENGTH VARCHAR2
  ,P_LESS VARCHAR2
  ,P_LEVEL VARCHAR2
  ,P_LEVELS VARCHAR2
  ,P_LIBRARY VARCHAR2
  ,P_LIKE_EXPAND VARCHAR2
  ,P_LIKE2 VARCHAR2
  ,P_LIKE4 VARCHAR2
  ,P_LIKEC VARCHAR2
  ,P_LIMIT VARCHAR2
  ,P_LINK VARCHAR2
  ,P_LIST VARCHAR2
  ,P_LOB VARCHAR2
  ,P_LOCAL VARCHAR2
  ,P_LOCAL_INDEXES VARCHAR2
  ,P_LOCALTIME VARCHAR2
  ,P_LOCALTIMESTAMP VARCHAR2
  ,P_LOCATION VARCHAR2
  ,P_LOCATOR VARCHAR2
  ,P_LOCKED VARCHAR2
  ,P_LOG VARCHAR2
  ,P_LOGFILE VARCHAR2
  ,P_LOGGING VARCHAR2
  ,P_LOGICAL VARCHAR2
  ,P_LOGICAL_READS_PER_CALL VARCHAR2
  ,P_LOGICAL_READS_PER_SESSION VARCHAR2
  ,P_LOGOFF VARCHAR2
  ,P_LOGON VARCHAR2
  ,P_M VARCHAR2
  ,P_MAIN VARCHAR2
  ,P_MANAGE VARCHAR2
  ,P_MANAGED VARCHAR2
  ,P_MANAGEMENT VARCHAR2
  ,P_MANUAL VARCHAR2
  ,P_MAP VARCHAR2
  ,P_MAPPING VARCHAR2
  ,P_MASTER VARCHAR2
  ,P_MATCHED VARCHAR2
  ,P_MATERIALIZE VARCHAR2
  ,P_MATERIALIZED VARCHAR2
  ,P_MAX VARCHAR2
  ,P_MAXARCHLOGS VARCHAR2
  ,P_MAXDATAFILES VARCHAR2
  ,P_MAXEXTENTS VARCHAR2
  ,P_MAXIMIZE VARCHAR2
  ,P_MAXINSTANCES VARCHAR2
  ,P_MAXLOGFILES VARCHAR2
  ,P_MAXLOGHISTORY VARCHAR2
  ,P_MAXLOGMEMBERS VARCHAR2
  ,P_MAXSIZE VARCHAR2
  ,P_MAXTRANS VARCHAR2
  ,P_MAXVALUE VARCHAR2
  ,P_MEASURES VARCHAR2
  ,P_MEMBER VARCHAR2
  ,P_MEMORY VARCHAR2
  ,P_MERGE VARCHAR2
  ,P_MERGE_AJ VARCHAR2
  ,P_MERGE_CONST_ON VARCHAR2
  ,P_MERGE_SJ VARCHAR2
  ,P_METHOD VARCHAR2
  ,P_MIGRATE VARCHAR2
  ,P_MIN VARCHAR2
  ,P_MINEXTENTS VARCHAR2
  ,P_MINIMIZE VARCHAR2
  ,P_MINIMUM VARCHAR2
  ,P_MINUS_NULL VARCHAR2
  ,P_MINUTE VARCHAR2
  ,P_MINVALUE VARCHAR2
  ,P_MIRROR VARCHAR2
  ,P_MLSLABEL VARCHAR2
  ,P_MODEL VARCHAR2
  ,P_MODEL_COMPILE_SUBQUERY VARCHAR2
  ,P_MODEL_DONTVERIFY_UNIQUENESS VARCHAR2
  ,P_MODEL_DYNAMIC_SUBQUERY VARCHAR2
  ,P_MODEL_MIN_ANALYSIS VARCHAR2
  ,P_MODEL_NO_ANALYSIS VARCHAR2
  ,P_MODEL_PBY VARCHAR2
  ,P_MODEL_PUSH_REF VARCHAR2
  ,P_MODIFY VARCHAR2
  ,P_MONITORING VARCHAR2
  ,P_MONTH VARCHAR2
  ,P_MOUNT VARCHAR2
  ,P_MOVE VARCHAR2
  ,P_MOVEMENT VARCHAR2
  ,P_MULTISET VARCHAR2
  ,P_MV_MERGE VARCHAR2
  ,P_NAME VARCHAR2
  ,P_NAMED VARCHAR2
  ,P_NAN VARCHAR2
  ,P_NATIONAL VARCHAR2
  ,P_NATIVE VARCHAR2
  ,P_NATIVE_FULL_OUTER_JOIN VARCHAR2
  ,P_NATURAL VARCHAR2
  ,P_NAV VARCHAR2
  ,P_NCHAR VARCHAR2
  ,P_NCHAR_CS VARCHAR2
  ,P_NCLOB VARCHAR2
  ,P_NEEDED VARCHAR2
  ,P_NESTED VARCHAR2
  ,P_NESTED_TABLE_FAST_INSERT VARCHAR2
  ,P_NESTED_TABLE_GET_REFS VARCHAR2
  ,P_NESTED_TABLE_ID VARCHAR2
  ,P_NESTED_TABLE_SET_REFS VARCHAR2
  ,P_NESTED_TABLE_SET_SETID VARCHAR2
  ,P_NETWORK VARCHAR2
  ,P_NEVER VARCHAR2
  ,P_NEW VARCHAR2
  ,P_NEXT VARCHAR2
  ,P_NL_AJ VARCHAR2
  ,P_NL_SJ VARCHAR2
  ,P_NLS_CALENDAR VARCHAR2
  ,P_NLS_CHARACTERSET VARCHAR2
  ,P_NLS_COMP VARCHAR2
  ,P_NLS_CURRENCY VARCHAR2
  ,P_NLS_DATE_FORMAT VARCHAR2
  ,P_NLS_DATE_LANGUAGE VARCHAR2
  ,P_NLS_ISO_CURRENCY VARCHAR2
  ,P_NLS_LANG VARCHAR2
  ,P_NLS_LANGUAGE VARCHAR2
  ,P_NLS_LENGTH_SEMANTICS VARCHAR2
  ,P_NLS_NCHAR_CONV_EXCP VARCHAR2
  ,P_NLS_NUMERIC_CHARACTERS VARCHAR2
  ,P_NLS_SORT VARCHAR2
  ,P_NLS_SPECIAL_CHARS VARCHAR2
  ,P_NLS_TERRITORY VARCHAR2
  ,P_NO VARCHAR2
  ,P_NO_ACCESS VARCHAR2
  ,P_NO_BASETABLE_MULTIMV_REWRITE VARCHAR2
  ,P_NO_BUFFER VARCHAR2
  ,P_NO_CARTESIAN VARCHAR2
  ,P_NO_CONNECT_BY_COST_BASED VARCHAR2
  ,P_NO_CONNECT_BY_FILTERING VARCHAR2
  ,P_NO_CPU_COSTING VARCHAR2
  ,P_NO_ELIMINATE_JOIN VARCHAR2
  ,P_NO_ELIMINATE_OBY VARCHAR2
  ,P_NO_ELIMINATE_OUTER_JOIN VARCHAR2
  ,P_NO_EXPAND VARCHAR2
  ,P_NO_EXPAND_GSET_TO_UNION VARCHAR2
  ,P_NO_FACT VARCHAR2
  ,P_NO_FILTERING VARCHAR2
  ,P_NO_INDEX VARCHAR2
  ,P_NO_INDEX_FFS VARCHAR2
  ,P_NO_INDEX_RS VARCHAR2
  ,P_NO_INDEX_SS VARCHAR2
  ,P_NO_MERGE VARCHAR2
  ,P_NO_MODEL_PUSH_REF VARCHAR2
  ,P_NO_MONITORING VARCHAR2
  ,P_NO_MULTIMV_REWRITE VARCHAR2
  ,P_NO_NATIVE_FULL_OUTER_JOIN VARCHAR2
  ,P_NO_ORDER_ROLLUPS VARCHAR2
  ,P_NO_PARALLEL VARCHAR2
  ,P_NO_PARALLEL_INDEX VARCHAR2
  ,P_NO_PARTIAL_COMMIT VARCHAR2
  ,P_NO_PRUNE_GSETS VARCHAR2
  ,P_NO_PULL_PRED VARCHAR2
  ,P_NO_PUSH_PRED VARCHAR2
  ,P_NO_PUSH_SUBQ VARCHAR2
  ,P_NO_PX_JOIN_FILTER VARCHAR2
  ,P_NO_QKN_BUFF VARCHAR2
  ,P_NO_QUERY_TRANSFORMATION VARCHAR2
  ,P_NO_REF_CASCADE VARCHAR2
  ,P_NO_REWRITE VARCHAR2
  ,P_NO_SEMIJOIN VARCHAR2
  ,P_NO_SET_TO_JOIN VARCHAR2
  ,P_NO_SQL_TUNE VARCHAR2
  ,P_NO_STAR_TRANSFORMATION VARCHAR2
  ,P_NO_STATS_GSETS VARCHAR2
  ,P_NO_SWAP_JOIN_INPUTS VARCHAR2
  ,P_NO_TEMP_TABLE VARCHAR2
  ,P_NO_UNNEST VARCHAR2
  ,P_NO_USE_HASH VARCHAR2
  ,P_NO_USE_HASH_AGGREGATION VARCHAR2
  ,P_NO_USE_MERGE VARCHAR2
  ,P_NO_USE_NL VARCHAR2
  ,P_NO_XML_DML_REWRITE VARCHAR2
  ,P_NO_XML_QUERY_REWRITE VARCHAR2
  ,P_NOAPPEND VARCHAR2
  ,P_NOARCHIVELOG VARCHAR2
  ,P_NOAUDIT VARCHAR2
  ,P_NOCACHE VARCHAR2
  ,P_NOCPU_COSTING VARCHAR2
  ,P_NOCYCLE VARCHAR2
  ,P_NODELAY VARCHAR2
  ,P_NOFORCE VARCHAR2
  ,P_NOGUARANTEE VARCHAR2
  ,P_NOLOGGING VARCHAR2
  ,P_NOMAPPING VARCHAR2
  ,P_NOMAXVALUE VARCHAR2
  ,P_NOMINIMIZE VARCHAR2
  ,P_NOMINVALUE VARCHAR2
  ,P_NOMONITORING VARCHAR2
  ,P_NONE VARCHAR2
  ,P_NOORDER VARCHAR2
  ,P_NOOVERRIDE VARCHAR2
  ,P_NOPARALLEL VARCHAR2
  ,P_NOPARALLEL_INDEX VARCHAR2
  ,P_NORELY VARCHAR2
  ,P_NOREPAIR VARCHAR2
  ,P_NORESETLOGS VARCHAR2
  ,P_NOREVERSE VARCHAR2
  ,P_NOREWRITE VARCHAR2
  ,P_NORMAL VARCHAR2
  ,P_NOROWDEPENDENCIES VARCHAR2
  ,P_NOSEGMENT VARCHAR2
  ,P_NOSORT VARCHAR2
  ,P_NOSTRICT VARCHAR2
  ,P_NOSWITCH VARCHAR2
  ,P_NOTHING VARCHAR2
  ,P_NOTIFICATION VARCHAR2
  ,P_NOVALIDATE VARCHAR2
  ,P_NULLS VARCHAR2
  ,P_NUM_INDEX_KEYS VARCHAR2
  ,P_NUMERIC VARCHAR2
  ,P_NVARCHAR2 VARCHAR2
  ,P_OBJECT VARCHAR2
  ,P_OBJNO VARCHAR2
  ,P_OBJNO_REUSE VARCHAR2
  ,P_OFF VARCHAR2
  ,P_OFFLINE VARCHAR2
  ,P_OID VARCHAR2
  ,P_OIDINDEX VARCHAR2
  ,P_OLD VARCHAR2
  ,P_OLD_PUSH_PRED VARCHAR2
  ,P_ONLINE VARCHAR2
  ,P_ONLY VARCHAR2
  ,P_OPAQUE VARCHAR2
  ,P_OPAQUE_TRANSFORM VARCHAR2
  ,P_OPAQUE_XCANONICAL VARCHAR2
  ,P_OPCODE VARCHAR2
  ,P_OPEN VARCHAR2
  ,P_OPERATOR VARCHAR2
  ,P_OPT_ESTIMATE VARCHAR2
  ,P_OPT_PARAM VARCHAR2
  ,P_OPTIMAL VARCHAR2
  ,P_OPTIMIZER_FEATURES_ENABLE VARCHAR2
  ,P_OPTIMIZER_GOAL VARCHAR2
  ,P_OR_EXPAND VARCHAR2
  ,P_ORA_ROWSCN VARCHAR2
  ,P_ORDERED VARCHAR2
  ,P_ORDERED_PREDICATES VARCHAR2
  ,P_ORDINALITY VARCHAR2
  ,P_ORGANIZATION VARCHAR2
  ,P_OUT_OF_LINE VARCHAR2
  ,P_OUTER VARCHAR2
  ,P_OUTLINE VARCHAR2
  ,P_OUTLINE_LEAF VARCHAR2
  ,P_OVER VARCHAR2
  ,P_OVERFLOW VARCHAR2
  ,P_OVERFLOW_NOMOVE VARCHAR2
  ,P_OVERLAPS VARCHAR2
  ,P_OVERRIDING VARCHAR2
  ,P_OWN VARCHAR2
  ,P_P VARCHAR2
  ,P_PACKAGE VARCHAR2
  ,P_PACKAGES VARCHAR2
  ,P_PARALLEL VARCHAR2
  ,P_PARALLEL_INDEX VARCHAR2
  ,P_PARAMETERS VARCHAR2
  ,P_PARENT VARCHAR2
  ,P_PARITY VARCHAR2
  ,P_PARTIALLY VARCHAR2
  ,P_PARTITION VARCHAR2
  ,P_PARTITION_HASH VARCHAR2
  ,P_PARTITION_LIST VARCHAR2
  ,P_PARTITION_RANGE VARCHAR2
  ,P_PARTITIONS VARCHAR2
  ,P_PASSING VARCHAR2
  ,P_PASSWORD VARCHAR2
  ,P_PASSWORD_GRACE_TIME VARCHAR2
  ,P_PASSWORD_LIFE_TIME VARCHAR2
  ,P_PASSWORD_LOCK_TIME VARCHAR2
  ,P_PASSWORD_REUSE_MAX VARCHAR2
  ,P_PASSWORD_REUSE_TIME VARCHAR2
  ,P_PASSWORD_VERIFY_FUNCTION VARCHAR2
  ,P_PATH VARCHAR2
  ,P_PATHS VARCHAR2
  ,P_PCTINCREASE VARCHAR2
  ,P_PCTTHRESHOLD VARCHAR2
  ,P_PCTUSED VARCHAR2
  ,P_PCTVERSION VARCHAR2
  ,P_PERCENT VARCHAR2
  ,P_PERFORMANCE VARCHAR2
  ,P_PERMANENT VARCHAR2
  ,P_PFILE VARCHAR2
  ,P_PHYSICAL VARCHAR2
  ,P_PIV_GB VARCHAR2
  ,P_PIV_SSF VARCHAR2
  ,P_PLAN VARCHAR2
  ,P_PLSQL_CCFLAGS VARCHAR2
  ,P_PLSQL_CODE_TYPE VARCHAR2
  ,P_PLSQL_DEBUG VARCHAR2
  ,P_PLSQL_OPTIMIZE_LEVEL VARCHAR2
  ,P_PLSQL_WARNINGS VARCHAR2
  ,P_POINT VARCHAR2
  ,P_POLICY VARCHAR2
  ,P_POST_TRANSACTION VARCHAR2
  ,P_POWER VARCHAR2
  ,P_PQ_DISTRIBUTE VARCHAR2
  ,P_PQ_MAP VARCHAR2
  ,P_PQ_NOMAP VARCHAR2
  ,P_PREBUILT VARCHAR2
  ,P_PRECEDING VARCHAR2
  ,P_PRECISION VARCHAR2
  ,P_PRECOMPUTE_SUBQUERY VARCHAR2
  ,P_PREPARE VARCHAR2
  ,P_PRESENT VARCHAR2
  ,P_PRESERVE VARCHAR2
  ,P_PRESERVE_OID VARCHAR2
  ,P_PRIMARY VARCHAR2
  ,P_PRIVATE VARCHAR2
  ,P_PRIVATE_SGA VARCHAR2
  ,P_PRIVILEGE VARCHAR2
  ,P_PRIVILEGES VARCHAR2
  ,P_PROCEDURE VARCHAR2
  ,P_PROFILE VARCHAR2
  ,P_PROGRAM VARCHAR2
  ,P_PROJECT VARCHAR2
  ,P_PROTECTED VARCHAR2
  ,P_PROTECTION VARCHAR2
  ,P_PULL_PRED VARCHAR2
  ,P_PURGE VARCHAR2
  ,P_PUSH_PRED VARCHAR2
  ,P_PUSH_SUBQ VARCHAR2
  ,P_PX_GRANULE VARCHAR2
  ,P_PX_JOIN_FILTER VARCHAR2
  ,P_QB_NAME VARCHAR2
  ,P_QUERY VARCHAR2
  ,P_QUERY_BLOCK VARCHAR2
  ,P_QUEUE VARCHAR2
  ,P_QUEUE_CURR VARCHAR2
  ,P_QUEUE_ROWP VARCHAR2
  ,P_QUIESCE VARCHAR2
  ,P_QUOTA VARCHAR2
  ,P_RANDOM VARCHAR2
  ,P_RANGE VARCHAR2
  ,P_RAPIDLY VARCHAR2
  ,P_RBA VARCHAR2
  ,P_RBO_OUTLINE VARCHAR2
  ,P_READ VARCHAR2
  ,P_READS VARCHAR2
  ,P_REAL VARCHAR2
  ,P_REBALANCE VARCHAR2
  ,P_REBUILD VARCHAR2
  ,P_RECORDS_PER_BLOCK VARCHAR2
  ,P_RECOVER VARCHAR2
  ,P_RECOVERABLE VARCHAR2
  ,P_RECOVERY VARCHAR2
  ,P_RECYCLE VARCHAR2
  ,P_RECYCLEBIN VARCHAR2
  ,P_REDUCED VARCHAR2
  ,P_REDUNDANCY VARCHAR2
  ,P_REF VARCHAR2
  ,P_REF_CASCADE_CURSOR VARCHAR2
  ,P_REFERENCE VARCHAR2
  ,P_REFERENCED VARCHAR2
  ,P_REFERENCES VARCHAR2
  ,P_REFRESH VARCHAR2
  ,P_REGEXP_LIKE VARCHAR2
  ,P_REGISTER VARCHAR2
  ,P_REJECT VARCHAR2
  ,P_REKEY VARCHAR2
  ,P_RELATIONAL VARCHAR2
  ,P_RELY VARCHAR2
  ,P_REMOTE_MAPPED VARCHAR2
  ,P_REPAIR VARCHAR2
  ,P_REPLACE VARCHAR2
  ,P_REQUIRED VARCHAR2
  ,P_RESET VARCHAR2
  ,P_RESETLOGS VARCHAR2
  ,P_RESIZE VARCHAR2
  ,P_RESOLVE VARCHAR2
  ,P_RESOLVER VARCHAR2
  ,P_RESTORE VARCHAR2
  ,P_RESTORE_AS_INTERVALS VARCHAR2
  ,P_RESTRICT VARCHAR2
  ,P_RESTRICT_ALL_REF_CONS VARCHAR2
  ,P_RESTRICTED VARCHAR2
  ,P_RESUMABLE VARCHAR2
  ,P_RESUME VARCHAR2
  ,P_RETENTION VARCHAR2
  ,P_RESULT VARCHAR2
  ,P_RETURN VARCHAR2
  ,P_RETURNING VARCHAR2
  ,P_REUSE VARCHAR2
  ,P_REVERSE VARCHAR2
  ,P_REWRITE VARCHAR2
  ,P_REWRITE_OR_ERROR VARCHAR2
  ,P_RIGHT VARCHAR2
  ,P_ROLE VARCHAR2
  ,P_ROLES VARCHAR2
  ,P_ROLLBACK VARCHAR2
  ,P_ROLLING VARCHAR2
  ,P_ROLLUP VARCHAR2
  ,P_ROW VARCHAR2
  ,P_ROW_LENGTH VARCHAR2
  ,P_ROWDEPENDENCIES VARCHAR2
  ,P_ROWID VARCHAR2
  ,P_ROWNUM VARCHAR2
  ,P_ROWS VARCHAR2
  ,P_RULE VARCHAR2
  ,P_RULES VARCHAR2
  ,P_SALT VARCHAR2
  ,P_SAMPLE VARCHAR2
  ,P_SAVE_AS_INTERVALS VARCHAR2
  ,P_SAVEPOINT VARCHAR2
  ,P_SB4 VARCHAR2
  ,P_SCALE VARCHAR2
  ,P_SCALE_ROWS VARCHAR2
  ,P_SCAN VARCHAR2
  ,P_SCAN_INSTANCES VARCHAR2
  ,P_SCHEDULER VARCHAR2
  ,P_SCHEMA VARCHAR2
  ,P_SCN VARCHAR2
  ,P_SCN_ASCENDING VARCHAR2
  ,P_SCOPE VARCHAR2
  ,P_SD_ALL VARCHAR2
  ,P_SD_INHIBIT VARCHAR2
  ,P_SD_SHOW VARCHAR2
  ,P_SECOND VARCHAR2
  ,P_SECURITY VARCHAR2
  ,P_SEED VARCHAR2
  ,P_SEG_BLOCK VARCHAR2
  ,P_SEG_FILE VARCHAR2
  ,P_SEGMENT VARCHAR2
  ,P_SELECTIVITY VARCHAR2
  ,P_SEMIJOIN VARCHAR2
  ,P_SEMIJOIN_DRIVER VARCHAR2
  ,P_SEQUENCE VARCHAR2
  ,P_SEQUENCED VARCHAR2
  ,P_SEQUENTIAL VARCHAR2
  ,P_SERIALIZABLE VARCHAR2
  ,P_SERVERERROR VARCHAR2
  ,P_SESSION VARCHAR2
  ,P_SESSION_CACHED_CURSORS VARCHAR2
  ,P_SESSIONS_PER_USER VARCHAR2
  ,P_SESSIONTIMEZONE VARCHAR2
  ,P_SESSIONTZNAME VARCHAR2
  ,P_SET_TO_JOIN VARCHAR2
  ,P_SETS VARCHAR2
  ,P_SETTINGS VARCHAR2
  ,P_SEVERE VARCHAR2
  ,P_SHARED VARCHAR2
  ,P_SHARED_POOL VARCHAR2
  ,P_SHRINK VARCHAR2
  ,P_SHUTDOWN VARCHAR2
  ,P_SIBLINGS VARCHAR2
  ,P_SID VARCHAR2
  ,P_SIMPLE VARCHAR2
  ,P_SINGLE VARCHAR2
  ,P_SINGLETASK VARCHAR2
  ,P_SKIP VARCHAR2
  ,P_SKIP_EXT_OPTIMIZER VARCHAR2
  ,P_SKIP_UNQ_UNUSABLE_IDX VARCHAR2
  ,P_SKIP_UNUSABLE_INDEXES VARCHAR2
  ,P_SMALLFILE VARCHAR2
  ,P_SNAPSHOT VARCHAR2
  ,P_SOME VARCHAR2
  ,P_SORT VARCHAR2
  ,P_SOURCE VARCHAR2
  ,P_SPACE VARCHAR2
  ,P_SPECIFICATION VARCHAR2
  ,P_SPFILE VARCHAR2
  ,P_SPLIT VARCHAR2
  ,P_SPREADSHEET VARCHAR2
  ,P_SQL VARCHAR2
  ,P_SQL_TRACE VARCHAR2
  ,P_SQLLDR VARCHAR2
  ,P_STANDALONE VARCHAR2
  ,P_STANDBY VARCHAR2
  ,P_STAR VARCHAR2
  ,P_STAR_TRANSFORMATION VARCHAR2
  ,P_STARTUP VARCHAR2
  ,P_STATEMENT_ID VARCHAR2
  ,P_STATIC VARCHAR2
  ,P_STATISTICS VARCHAR2
  ,P_STOP VARCHAR2
  ,P_STORAGE VARCHAR2
  ,P_STORE VARCHAR2
  ,P_STREAMS VARCHAR2
  ,P_STRICT VARCHAR2
  ,P_STRING VARCHAR2
  ,P_STRIP VARCHAR2
  ,P_STRUCTURE VARCHAR2
  ,P_SUBMULTISET VARCHAR2
  ,P_SUBPARTITION VARCHAR2
  ,P_SUBPARTITION_REL VARCHAR2
  ,P_SUBPARTITIONS VARCHAR2
  ,P_SUBQUERIES VARCHAR2
  ,P_SUBSTITUTABLE VARCHAR2
  ,P_SUCCESSFUL VARCHAR2
  ,P_SUMMARY VARCHAR2
  ,P_SUPPLEMENTAL VARCHAR2
  ,P_SUSPEND VARCHAR2
  ,P_SWAP_JOIN_INPUTS VARCHAR2
  ,P_SWITCH VARCHAR2
  ,P_SWITCHOVER VARCHAR2
  ,P_SYS_DL_CURSOR VARCHAR2
  ,P_SYS_FBT_INSDEL VARCHAR2
  ,P_SYS_OP_BITVEC VARCHAR2
  ,P_SYS_OP_CAST VARCHAR2
  ,P_SYS_OP_ENFORCE_NOT_NULL$ VARCHAR2
  ,P_SYS_OP_EXTRACT VARCHAR2
  ,P_SYS_OP_NOEXPAND VARCHAR2
  ,P_SYS_OP_NTCIMG$ VARCHAR2
  ,P_SYS_PARALLEL_TXN VARCHAR2
  ,P_SYS_RID_ORDER VARCHAR2
  ,P_SYSAUX VARCHAR2
  ,P_SYSDATE VARCHAR2
  ,P_SYSDBA VARCHAR2
  ,P_SYSOPER VARCHAR2
  ,P_SYSTEM VARCHAR2
  ,P_SYSTIMESTAMP VARCHAR2
  ,P_T VARCHAR2
  ,P_TABLE_STATS VARCHAR2
  ,P_TABLES VARCHAR2
  ,P_TABLESPACE VARCHAR2
  ,P_TABLESPACE_NO VARCHAR2
  ,P_TABNO VARCHAR2
  ,P_TEMP_TABLE VARCHAR2
  ,P_TEMPFILE VARCHAR2
  ,P_TEMPLATE VARCHAR2
  ,P_TEMPORARY VARCHAR2
  ,P_TEST VARCHAR2
  ,P_THAN VARCHAR2
  ,P_THE VARCHAR2
  ,P_THREAD VARCHAR2
  ,P_THROUGH VARCHAR2
  ,P_TIME VARCHAR2
  ,P_TIME_ZONE VARCHAR2
  ,P_TIMEOUT VARCHAR2
  ,P_TIMESTAMP VARCHAR2
  ,P_TIMEZONE_ABBR VARCHAR2
  ,P_TIMEZONE_HOUR VARCHAR2
  ,P_TIMEZONE_MINUTE VARCHAR2
  ,P_TIMEZONE_OFFSET VARCHAR2
  ,P_TIMEZONE_REGION VARCHAR2
  ,P_TIV_GB VARCHAR2
  ,P_TIV_SSF VARCHAR2
  ,P_TO_CHAR VARCHAR2
  ,P_TOPLEVEL VARCHAR2
  ,P_TRACE VARCHAR2
  ,P_TRACING VARCHAR2
  ,P_TRACKING VARCHAR2
  ,P_TRAILING VARCHAR2
  ,P_TRANSACTION VARCHAR2
  ,P_TRANSITIONAL VARCHAR2
  ,P_TREAT VARCHAR2
  ,P_TRIGGERS VARCHAR2
  ,P_TRUE VARCHAR2
  ,P_TRUNCATE VARCHAR2
  ,P_TRUSTED VARCHAR2
  ,P_TUNING VARCHAR2
  ,P_TX VARCHAR2
  ,P_TYPE VARCHAR2
  ,P_TYPES VARCHAR2
  ,P_TZ_OFFSET VARCHAR2
  ,P_U VARCHAR2
  ,P_UB2 VARCHAR2
  ,P_UBA VARCHAR2
  ,P_UID VARCHAR2
  ,P_UNARCHIVED VARCHAR2
  ,P_UNBOUND VARCHAR2
  ,P_UNBOUNDED VARCHAR2
  ,P_UNDER VARCHAR2
  ,P_UNDO VARCHAR2
  ,P_UNDROP VARCHAR2
  ,P_UNIFORM VARCHAR2
  ,P_UNLIMITED VARCHAR2
  ,P_UNLOCK VARCHAR2
  ,P_UNNEST VARCHAR2
  ,P_UNPACKED VARCHAR2
  ,P_UNPROTECTED VARCHAR2
  ,P_UNQUIESCE VARCHAR2
  ,P_UNRECOVERABLE VARCHAR2
  ,P_UNTIL VARCHAR2
  ,P_UNUSABLE VARCHAR2
  ,P_UNUSED VARCHAR2
  ,P_UPD_INDEXES VARCHAR2
  ,P_UPD_JOININDEX VARCHAR2
  ,P_UPDATABLE VARCHAR2
  ,P_UPDATED VARCHAR2
  ,P_UPGRADE VARCHAR2
  ,P_UPSERT VARCHAR2
  ,P_UROWID VARCHAR2
  ,P_USAGE VARCHAR2
  ,P_USE VARCHAR2
  ,P_USE_ANTI VARCHAR2
  ,P_USE_CONCAT VARCHAR2
  ,P_USE_HASH VARCHAR2
  ,P_USE_HASH_AGGREGATION VARCHAR2
  ,P_USE_MERGE VARCHAR2
  ,P_USE_NL VARCHAR2
  ,P_USE_NL_WITH_INDEX VARCHAR2
  ,P_USE_PRIVATE_OUTLINES VARCHAR2
  ,P_USE_SEMI VARCHAR2
  ,P_USE_STORED_OUTLINES VARCHAR2
  ,P_USE_TTT_FOR_GSETS VARCHAR2
  ,P_USE_WEAK_NAME_RESL VARCHAR2
  ,P_USER VARCHAR2
  ,P_USER_DEFINED VARCHAR2
  ,P_USER_RECYCLEBIN VARCHAR2
  ,P_USERS VARCHAR2
  ,P_USING VARCHAR2
  ,P_VALIDATE VARCHAR2
  ,P_VALIDATION VARCHAR2
  ,P_VALUE VARCHAR2
  ,P_VARCHAR2 VARCHAR2
  ,P_VARRAY VARCHAR2
  ,P_VARYING VARCHAR2
  ,P_VECTOR_READ VARCHAR2
  ,P_VECTOR_READ_TRACE VARCHAR2
  ,P_VERSION VARCHAR2
  ,P_VERSIONS VARCHAR2
  ,P_WAIT VARCHAR2
  ,P_WALLET VARCHAR2
  ,P_WELLFORMED VARCHAR2
  ,P_WHEN VARCHAR2
  ,P_WHENEVER VARCHAR2
  ,P_WHITESPACE VARCHAR2
  ,P_WITHIN VARCHAR2
  ,P_WITHOUT VARCHAR2
  ,P_WORK VARCHAR2
  ,P_WRAPPED VARCHAR2
  ,P_WRITE VARCHAR2
  ,P_X_DYN_PRUNE VARCHAR2
  ,P_XID VARCHAR2
  ,P_XML_DML_RWT_STMT VARCHAR2
  ,P_XMLATTRIBUTES VARCHAR2
  ,P_XMLCOLATTVAL VARCHAR2
  ,P_XMLELEMENT VARCHAR2
  ,P_XMLFOREST VARCHAR2
  ,P_XMLNAMESPACES VARCHAR2
  ,P_XMLPARSE VARCHAR2
  ,P_XMLPI VARCHAR2
  ,P_XMLQUERY VARCHAR2
  ,P_XMLROOT VARCHAR2
  ,P_XMLSCHEMA VARCHAR2
  ,P_XMLSERIALIZE VARCHAR2
  ,P_XMLTABLE VARCHAR2
  ,P_XMLTYPE VARCHAR2
  ,P_YEAR VARCHAR2
  ,P_YES VARCHAR2
  ,P_ZONE VARCHAR2
  )
RETURN VARCHAR2 
AS
  /** Unreserved Keyword Word FALSE **/
  FALSE VARCHAR2(240);
  /** Unreserved Keyword Word TRUE **/
  TRUE VARCHAR2(240);
  /** Unreserved Keyword Word A **/
  A VARCHAR2(240);
  /** Unreserved Keyword Word ABORT **/
  ABORT VARCHAR2(240);
  /** Unreserved Keyword Word ACCESS **/
  ACCESS VARCHAR2(240);
  /** Unreserved Keyword Word ACCESSED **/
  ACCESSED VARCHAR2(240);
  /** Unreserved Keyword Word ACCOUNT **/
  ACCOUNT VARCHAR2(240);
  /** Unreserved Keyword Word ACTIVATE **/
  ACTIVATE VARCHAR2(240);
  /** Unreserved Keyword Word ADD **/
  ADD VARCHAR2(240);
  /** Unreserved Keyword Word ADMIN **/
  ADMIN VARCHAR2(240);
  /** Unreserved Keyword Word ADMINISTER **/
  ADMINISTER VARCHAR2(240);
  /** Unreserved Keyword Word ADMINISTRATOR **/
  ADMINISTRATOR VARCHAR2(240);
  /** Unreserved Keyword Word ADVISE **/
  ADVISE VARCHAR2(240);
  /** Unreserved Keyword Word ADVISOR **/
  ADVISOR VARCHAR2(240);
  /** Unreserved Keyword Word AFTER **/
  AFTER VARCHAR2(240);
  /** Unreserved Keyword Word AGGREGATE **/
  AGGREGATE VARCHAR2(240);
  /** Unreserved Keyword Word ALIAS **/
  ALIAS VARCHAR2(240);
  /** Unreserved Keyword Word ALL_ROWS **/
  ALL_ROWS VARCHAR2(240);
  /** Unreserved Keyword Word ALLOCATE **/
  ALLOCATE VARCHAR2(240);
  /** Unreserved Keyword Word ALLOW **/
  ALLOW VARCHAR2(240);
  /** Unreserved Keyword Word ALWAYS **/
  ALWAYS VARCHAR2(240);
  /** Unreserved Keyword Word ANALYZE **/
  ANALYZE VARCHAR2(240);
  /** Unreserved Keyword Word ANCILLARY **/
  ANCILLARY VARCHAR2(240);
  /** Unreserved Keyword Word AND_EQUAL **/
  AND_EQUAL VARCHAR2(240);
  /** Unreserved Keyword Word ANTIJOIN **/
  ANTIJOIN VARCHAR2(240);
  /** Unreserved Keyword Word APPEND **/
  APPEND VARCHAR2(240);
  /** Unreserved Keyword Word APPLY **/
  APPLY VARCHAR2(240);
  /** Unreserved Keyword Word ARCHIVE **/
  ARCHIVE VARCHAR2(240);
  /** Unreserved Keyword Word ARCHIVELOG **/
  ARCHIVELOG VARCHAR2(240);
  /** Unreserved Keyword Word ARRAY **/
  ARRAY VARCHAR2(240);
  /** Unreserved Keyword Word ASSOCIATE **/
  ASSOCIATE VARCHAR2(240);
  /** Unreserved Keyword Word AT **/
   "AT" VARCHAR2(240);
  /** Unreserved Keyword Word ATTRIBUTE **/
  ATTRIBUTE VARCHAR2(240);
  /** Unreserved Keyword Word ATTRIBUTES **/
  ATTRIBUTES VARCHAR2(240);
  /** Unreserved Keyword Word AUDIT **/
  AUDIT VARCHAR2(240);
  /** Unreserved Keyword Word AUTHENTICATED **/
  AUTHENTICATED VARCHAR2(240);
  /** Unreserved Keyword Word AUTHENTICATION **/
  AUTHENTICATION VARCHAR2(240);
  /** Unreserved Keyword Word AUTHID **/
  AUTHID VARCHAR2(240);
  /** Unreserved Keyword Word AUTHORIZATION **/
  AUTHORIZATION VARCHAR2(240);
  /** Unreserved Keyword Word AUTO **/
  AUTO VARCHAR2(240);
  /** Unreserved Keyword Word AUTOALLOCATE **/
  AUTOALLOCATE VARCHAR2(240);
  /** Unreserved Keyword Word AUTOEXTEND **/
  AUTOEXTEND VARCHAR2(240);
  /** Unreserved Keyword Word AUTOMATIC **/
  AUTOMATIC VARCHAR2(240);
  /** Unreserved Keyword Word AVAILABILITY **/
  AVAILABILITY VARCHAR2(240);
  /** Unreserved Keyword Word BACKUP **/
  BACKUP VARCHAR2(240);
  /** Unreserved Keyword Word BATCH **/
  BATCH VARCHAR2(240);
  /** Unreserved Keyword Word BECOME **/
  BECOME VARCHAR2(240);
  /** Unreserved Keyword Word BEFORE **/
  BEFORE VARCHAR2(240);
  /** Unreserved Keyword Word BEGIN **/
  "BEGIN" VARCHAR2(240);
  /** Unreserved Keyword Word BEGIN_OUTLINE_DATA **/
  BEGIN_OUTLINE_DATA VARCHAR2(240);
  /** Unreserved Keyword Word BEHALF **/
  BEHALF VARCHAR2(240);
  /** Unreserved Keyword Word BFILE **/
  BFILE VARCHAR2(240);
  /** Unreserved Keyword Word BIGFILE **/
  BIGFILE VARCHAR2(240);
  /** Unreserved Keyword Word BINARY_DOUBLE **/
  BINARY_DOUBLE VARCHAR2(240);
  /** Unreserved Keyword Word BINARY_DOUBLE_INFINITY **/
  BINARY_DOUBLE_INFINITY VARCHAR2(240);
  /** Unreserved Keyword Word BINARY_DOUBLE_NAN **/
  BINARY_DOUBLE_NAN VARCHAR2(240);
  /** Unreserved Keyword Word BINARY_FLOAT **/
  BINARY_FLOAT VARCHAR2(240);
  /** Unreserved Keyword Word BINARY_FLOAT_INFINITY **/
  BINARY_FLOAT_INFINITY VARCHAR2(240);
  /** Unreserved Keyword Word BINARY_FLOAT_NAN **/
  BINARY_FLOAT_NAN VARCHAR2(240);
  /** Unreserved Keyword Word BINDING **/
  BINDING VARCHAR2(240);
  /** Unreserved Keyword Word BITMAP **/
  BITMAP VARCHAR2(240);
  /** Unreserved Keyword Word BITMAP_TREE **/
  BITMAP_TREE VARCHAR2(240);
  /** Unreserved Keyword Word BITMAPS **/
  BITMAPS VARCHAR2(240);
  /** Unreserved Keyword Word BITS **/
  BITS VARCHAR2(240);
  /** Unreserved Keyword Word BLOB **/
  BLOB VARCHAR2(240);
  /** Unreserved Keyword Word BLOCK **/
  BLOCK VARCHAR2(240);
  /** Unreserved Keyword Word BLOCK_RANGE **/
  BLOCK_RANGE VARCHAR2(240);
  /** Unreserved Keyword Word BLOCKS **/
  BLOCKS VARCHAR2(240);
  /** Unreserved Keyword Word BLOCKSIZE **/
  BLOCKSIZE VARCHAR2(240);
  /** Unreserved Keyword Word BODY **/
  BODY VARCHAR2(240);
  /** Unreserved Keyword Word BOTH **/
  BOTH VARCHAR2(240);
  /** Unreserved Keyword Word BOUND **/
  BOUND VARCHAR2(240);
  /** Unreserved Keyword Word BROADCAST **/
  BROADCAST VARCHAR2(240);
  /** Unreserved Keyword Word BUFFER **/
  BUFFER VARCHAR2(240);
  /** Unreserved Keyword Word BUFFER_CACHE **/
  BUFFER_CACHE VARCHAR2(240);
  /** Unreserved Keyword Word BUFFER_POOL **/
  BUFFER_POOL VARCHAR2(240);
  /** Unreserved Keyword Word BUILD **/
  BUILD VARCHAR2(240);
  /** Unreserved Keyword Word BULK **/
  BULK VARCHAR2(240);
  /** Unreserved Keyword Word BY **/
   "BY" VARCHAR2(240);
  /** Unreserved Keyword Word BYPASS_RECURSIVE_CHECK **/
  BYPASS_RECURSIVE_CHECK VARCHAR2(240);
  /** Unreserved Keyword Word BYPASS_UJVC **/
  BYPASS_UJVC VARCHAR2(240);
  /** Unreserved Keyword Word BYTE **/
  BYTE VARCHAR2(240);
  /** Unreserved Keyword Word CACHE **/
  CACHE VARCHAR2(240);
  /** Unreserved Keyword Word CACHE_CB **/
  CACHE_CB VARCHAR2(240);
  /** Unreserved Keyword Word CACHE_INSTANCES **/
  CACHE_INSTANCES VARCHAR2(240);
  /** Unreserved Keyword Word CACHE_TEMP_TABLE **/
  CACHE_TEMP_TABLE VARCHAR2(240);
  /** Unreserved Keyword Word CALL **/
  CALL VARCHAR2(240);
  /** Unreserved Keyword Word CANCEL **/
  CANCEL VARCHAR2(240);
  /** Unreserved Keyword Word CARDINALITY **/
  CARDINALITY VARCHAR2(240);
  /** Unreserved Keyword Word CASCADE **/
  CASCADE VARCHAR2(240);
  /** Unreserved Keyword Word CASE **/
   "CASE" VARCHAR2(240);
  /** Unreserved Keyword Word CAST **/
  CAST VARCHAR2(240);
  /** Unreserved Keyword Word CATEGORY **/
  CATEGORY VARCHAR2(240);
  /** Unreserved Keyword Word CERTIFICATE **/
  CERTIFICATE VARCHAR2(240);
  /** Unreserved Keyword Word CFILE **/
  CFILE VARCHAR2(240);
  /** Unreserved Keyword Word CHAINED **/
  CHAINED VARCHAR2(240);
  /** Unreserved Keyword Word CHANGE **/
  CHANGE VARCHAR2(240);
  /** Unreserved Keyword Word CHAR_CS **/
  CHAR_CS VARCHAR2(240);
  /** Unreserved Keyword Word CHARACTER **/
  CHARACTER VARCHAR2(240);
  /** Unreserved Keyword Word CHECKPOINT **/
  CHECKPOINT VARCHAR2(240);
  /** Unreserved Keyword Word CHILD **/
  CHILD VARCHAR2(240);
  /** Unreserved Keyword Word CHOOSE **/
  CHOOSE VARCHAR2(240);
  /** Unreserved Keyword Word CHUNK **/
  CHUNK VARCHAR2(240);
  /** Unreserved Keyword Word CIV_GB **/
  CIV_GB VARCHAR2(240);
  /** Unreserved Keyword Word CLASS **/
  CLASS VARCHAR2(240);
  /** Unreserved Keyword Word CLEAR **/
  CLEAR VARCHAR2(240);
  /** Unreserved Keyword Word CLOB **/
  CLOB VARCHAR2(240);
  /** Unreserved Keyword Word CLONE **/
  CLONE VARCHAR2(240);
  /** Unreserved Keyword Word CLOSE **/
  CLOSE VARCHAR2(240);
  /** Unreserved Keyword Word CLOSE_CACHED_OPEN_CURSORS **/
  CLOSE_CACHED_OPEN_CURSORS VARCHAR2(240);
  /** Unreserved Keyword Word CLUSTERING_FACTOR **/
  CLUSTERING_FACTOR VARCHAR2(240);
  /** Unreserved Keyword Word COALESCE **/
  COALESCE VARCHAR2(240);
  /** Unreserved Keyword Word COARSE **/
  COARSE VARCHAR2(240);
  /** Unreserved Keyword Word COLLECT **/
  COLLECT VARCHAR2(240);
  /** Unreserved Keyword Word COLUMN **/
  COLUMN VARCHAR2(240);
  /** Unreserved Keyword Word COLUMN_STATS **/
  COLUMN_STATS VARCHAR2(240);
  /** Unreserved Keyword Word COLUMN_VALUE **/
  COLUMN_VALUE VARCHAR2(240);
  /** Unreserved Keyword Word COLUMNS **/
   "COLUMNS" VARCHAR2(240);
  /** Unreserved Keyword Word COMMENT **/
  COMMENT VARCHAR2(240);
  /** Unreserved Keyword Word COMMIT **/
  COMMIT VARCHAR2(240);
  /** Unreserved Keyword Word COMMITTED **/
  COMMITTED VARCHAR2(240);
  /** Unreserved Keyword Word COMPACT **/
  COMPACT VARCHAR2(240);
  /** Unreserved Keyword Word COMPATIBILITY **/
  COMPATIBILITY VARCHAR2(240);
  /** Unreserved Keyword Word COMPILE **/
  COMPILE VARCHAR2(240);
  /** Unreserved Keyword Word COMPLETE **/
  COMPLETE VARCHAR2(240);
  /** Unreserved Keyword Word COMPOSITE_LIMIT **/
  COMPOSITE_LIMIT VARCHAR2(240);
  /** Unreserved Keyword Word COMPUTE **/
  COMPUTE VARCHAR2(240);
  /** Unreserved Keyword Word CONFORMING **/
  CONFORMING VARCHAR2(240);
  /** Unreserved Keyword Word CONNECT_BY_COST_BASED **/
  CONNECT_BY_COST_BASED VARCHAR2(240);
  /** Unreserved Keyword Word CONNECT_BY_FILTERING **/
  CONNECT_BY_FILTERING VARCHAR2(240);
  /** Unreserved Keyword Word CONNECT_BY_ISCYCLE **/
  CONNECT_BY_ISCYCLE VARCHAR2(240);
  /** Unreserved Keyword Word CONNECT_BY_ISLEAF **/
  CONNECT_BY_ISLEAF VARCHAR2(240);
  /** Unreserved Keyword Word CONNECT_BY_ROOT **/
  CONNECT_BY_ROOT VARCHAR2(240);
  /** Unreserved Keyword Word CONNECT_TIME **/
  CONNECT_TIME VARCHAR2(240);
  /** Unreserved Keyword Word CONSIDER **/
  CONSIDER VARCHAR2(240);
  /** Unreserved Keyword Word CONSISTENT **/
  CONSISTENT VARCHAR2(240);
  /** Unreserved Keyword Word CONSTRAINT **/
  CONSTRAINT VARCHAR2(240);
  /** Unreserved Keyword Word CONSTRAINTS **/
  CONSTRAINTS VARCHAR2(240);
  /** Unreserved Keyword Word CONSTRUCTOR **/
  CONSTRUCTOR VARCHAR2(240);
  /** Unreserved Keyword Word CONTAINER **/
  CONTAINER VARCHAR2(240);
  /** Unreserved Keyword Word CONTENT **/
  CONTENT VARCHAR2(240);
  /** Unreserved Keyword Word CONTENTS **/
  CONTENTS VARCHAR2(240);
  /** Unreserved Keyword Word CONTEXT **/
  CONTEXT VARCHAR2(240);
  /** Unreserved Keyword Word CONTINUE **/
  CONTINUE VARCHAR2(240);
  /** Unreserved Keyword Word CONTROLFILE **/
  CONTROLFILE VARCHAR2(240);
  /** Unreserved Keyword Word CONVERT **/
  CONVERT VARCHAR2(240);
  /** Unreserved Keyword Word CORRUPTION **/
  CORRUPTION VARCHAR2(240);
  /** Unreserved Keyword Word COST **/
  COST VARCHAR2(240);
  /** Unreserved Keyword Word CPU_COSTING **/
  CPU_COSTING VARCHAR2(240);
  /** Unreserved Keyword Word CPU_PER_CALL **/
  CPU_PER_CALL VARCHAR2(240);
  /** Unreserved Keyword Word CPU_PER_SESSION **/
  CPU_PER_SESSION VARCHAR2(240);
  /** Unreserved Keyword Word CREATE_STORED_OUTLINES **/
  CREATE_STORED_OUTLINES VARCHAR2(240);
  /** Unreserved Keyword Word CROSS **/
  CROSS VARCHAR2(240);
  /** Unreserved Keyword Word CUBE **/
  CUBE VARCHAR2(240);
  /** Unreserved Keyword Word CUBE_GB **/
  CUBE_GB VARCHAR2(240);
  /** Unreserved Keyword Word CURRENT **/
  CURRENT VARCHAR2(240);
  /** Unreserved Keyword Word CURRENT_DATE **/
  CURRENT_DATE VARCHAR2(240);
  /** Unreserved Keyword Word CURRENT_SCHEMA **/
  CURRENT_SCHEMA VARCHAR2(240);
  /** Unreserved Keyword Word CURRENT_TIME **/
  CURRENT_TIME VARCHAR2(240);
  /** Unreserved Keyword Word CURRENT_TIMESTAMP **/
  CURRENT_TIMESTAMP VARCHAR2(240);
  /** Unreserved Keyword Word CURRENT_USER **/
  CURRENT_USER VARCHAR2(240);
  /** Unreserved Keyword Word CURSOR **/
   "CURSOR" VARCHAR2(240);
  /** Unreserved Keyword Word CURSOR_SHARING_EXACT **/
  CURSOR_SHARING_EXACT VARCHAR2(240);
  /** Unreserved Keyword Word CURSOR_SPECIFIC_SEGMENT **/
  CURSOR_SPECIFIC_SEGMENT VARCHAR2(240);
  /** Unreserved Keyword Word CYCLE **/
  CYCLE VARCHAR2(240);
  /** Unreserved Keyword Word DANGLING **/
  DANGLING VARCHAR2(240);
  /** Unreserved Keyword Word DATA **/
  DATA VARCHAR2(240);
  /** Unreserved Keyword Word DATABASE **/
  DATABASE VARCHAR2(240);
  /** Unreserved Keyword Word DATAFILE **/
  DATAFILE VARCHAR2(240);
  /** Unreserved Keyword Word DATAFILES **/
  DATAFILES VARCHAR2(240);
  /** Unreserved Keyword Word DATAOBJNO **/
  DATAOBJNO VARCHAR2(240);
  /** Unreserved Keyword Word DATE_MODE **/
  DATE_MODE VARCHAR2(240);
  /** Unreserved Keyword Word DAY **/
  DAY VARCHAR2(240);
  /** Unreserved Keyword Word DB_ROLE_CHANGE **/
  DB_ROLE_CHANGE VARCHAR2(240);
  /** Unreserved Keyword Word DBA **/
  DBA VARCHAR2(240);
  /** Unreserved Keyword Word DBA_RECYCLEBIN **/
  DBA_RECYCLEBIN VARCHAR2(240);
  /** Unreserved Keyword Word DBMS_STATS **/
  DBMS_STATS VARCHAR2(240);
  /** Unreserved Keyword Word DBTIMEZONE **/
  DBTIMEZONE VARCHAR2(240);
  /** Unreserved Keyword Word DDL **/
  DDL VARCHAR2(240);
  /** Unreserved Keyword Word DEALLOCATE **/
  DEALLOCATE VARCHAR2(240);
  /** Unreserved Keyword Word DEBUG **/
  DEBUG VARCHAR2(240);
  /** Unreserved Keyword Word DEC **/
  DEC VARCHAR2(240);
  /** Unreserved Keyword Word DECLARE **/
   "DECLARE" VARCHAR2(240);
  /** Unreserved Keyword Word DECREMENT **/
  DECREMENT VARCHAR2(240);
  /** Unreserved Keyword Word DECRYPT **/
  DECRYPT VARCHAR2(240);
  /** Unreserved Keyword Word DEFERRABLE **/
  DEFERRABLE VARCHAR2(240);
  /** Unreserved Keyword Word DEFERRED **/
  DEFERRED VARCHAR2(240);
  /** Unreserved Keyword Word DEFINED **/
  DEFINED VARCHAR2(240);
  /** Unreserved Keyword Word DEFINER **/
  DEFINER VARCHAR2(240);
  /** Unreserved Keyword Word DEGREE **/
  DEGREE VARCHAR2(240);
  /** Unreserved Keyword Word DELAY **/
  DELAY VARCHAR2(240);
  /** Unreserved Keyword Word DEMAND **/
  DEMAND VARCHAR2(240);
  /** Unreserved Keyword Word DENSE_RANK **/
  DENSE_RANK VARCHAR2(240);
  /** Unreserved Keyword Word DEQUEUE **/
  DEQUEUE VARCHAR2(240);
  /** Unreserved Keyword Word DEREF **/
  DEREF VARCHAR2(240);
  /** Unreserved Keyword Word DEREF_NO_REWRITE **/
  DEREF_NO_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word DETACHED **/
  DETACHED VARCHAR2(240);
  /** Unreserved Keyword Word DETERMINES **/
  DETERMINES VARCHAR2(240);
  /** Unreserved Keyword Word DICTIONARY **/
  DICTIONARY VARCHAR2(240);
  /** Unreserved Keyword Word DIMENSION **/
  DIMENSION VARCHAR2(240);
  /** Unreserved Keyword Word DIRECTORY **/
  DIRECTORY VARCHAR2(240);
  /** Unreserved Keyword Word DISABLE **/
  DISABLE VARCHAR2(240);
  /** Unreserved Keyword Word DISABLE_RPKE **/
  DISABLE_RPKE VARCHAR2(240);
  /** Unreserved Keyword Word DISASSOCIATE **/
  DISASSOCIATE VARCHAR2(240);
  /** Unreserved Keyword Word DISCONNECT **/
  DISCONNECT VARCHAR2(240);
  /** Unreserved Keyword Word DISK **/
  DISK VARCHAR2(240);
  /** Unreserved Keyword Word DISKGROUP **/
  DISKGROUP VARCHAR2(240);
  /** Unreserved Keyword Word DISKS **/
  DISKS VARCHAR2(240);
  /** Unreserved Keyword Word DISMOUNT **/
  DISMOUNT VARCHAR2(240);
  /** Unreserved Keyword Word DISTINGUISHED **/
  DISTINGUISHED VARCHAR2(240);
  /** Unreserved Keyword Word DISTRIBUTED **/
  DISTRIBUTED VARCHAR2(240);
  /** Unreserved Keyword Word DML **/
  DML VARCHAR2(240);
  /** Unreserved Keyword Word DML_UPDATE **/
  DML_UPDATE VARCHAR2(240);
  /** Unreserved Keyword Word DOCUMENT **/
  DOCUMENT VARCHAR2(240);
  /** Unreserved Keyword Word DOMAIN_INDEX_NO_SORT **/
  DOMAIN_INDEX_NO_SORT VARCHAR2(240);
  /** Unreserved Keyword Word DOMAIN_INDEX_SORT **/
  DOMAIN_INDEX_SORT VARCHAR2(240);
  /** Unreserved Keyword Word DOUBLE **/
  DOUBLE VARCHAR2(240);
  /** Unreserved Keyword Word DOWNGRADE **/
  DOWNGRADE VARCHAR2(240);
  /** Unreserved Keyword Word DRIVING_SITE **/
  DRIVING_SITE VARCHAR2(240);
  /** Unreserved Keyword Word DUMP **/
  DUMP VARCHAR2(240);
  /** Unreserved Keyword Word DYNAMIC **/
  DYNAMIC VARCHAR2(240);
  /** Unreserved Keyword Word DYNAMIC_SAMPLING **/
  DYNAMIC_SAMPLING VARCHAR2(240);
  /** Unreserved Keyword Word DYNAMIC_SAMPLING_EST_CDN **/
  DYNAMIC_SAMPLING_EST_CDN VARCHAR2(240);
  /** Unreserved Keyword Word E **/
  E VARCHAR2(240);
  /** Unreserved Keyword Word EACH **/
  EACH VARCHAR2(240);
  /** Unreserved Keyword Word ELEMENT **/
  ELEMENT VARCHAR2(240);
  /** Unreserved Keyword Word ELIMINATE_JOIN **/
  ELIMINATE_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word ELIMINATE_OBY **/
  ELIMINATE_OBY VARCHAR2(240);
  /** Unreserved Keyword Word ELIMINATE_OUTER_JOIN **/
  ELIMINATE_OUTER_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word EMPTY **/
  EMPTY VARCHAR2(240);
  /** Unreserved Keyword Word ENABLE **/
  ENABLE VARCHAR2(240);
  /** Unreserved Keyword Word ENCRYPT **/
  ENCRYPT VARCHAR2(240);
  /** Unreserved Keyword Word ENCRYPTION **/
  ENCRYPTION VARCHAR2(240);
  /** Unreserved Keyword Word END **/
  "END" VARCHAR2(240);
  /** Unreserved Keyword Word END_OUTLINE_DATA **/
  END_OUTLINE_DATA VARCHAR2(240);
  /** Unreserved Keyword Word ENFORCE **/
  ENFORCE VARCHAR2(240);
  /** Unreserved Keyword Word ENFORCED **/
  ENFORCED VARCHAR2(240);
  /** Unreserved Keyword Word ENQUEUE **/
  ENQUEUE VARCHAR2(240);
  /** Unreserved Keyword Word ENTERPRISE **/
  ENTERPRISE VARCHAR2(240);
  /** Unreserved Keyword Word ENTRY **/
  ENTRY VARCHAR2(240);
  /** Unreserved Keyword Word ERROR **/
  ERROR VARCHAR2(240);
  /** Unreserved Keyword Word ERROR_ON_OVERLAP_TIME **/
  ERROR_ON_OVERLAP_TIME VARCHAR2(240);
  /** Unreserved Keyword Word ERRORS **/
  ERRORS VARCHAR2(240);
  /** Unreserved Keyword Word ESCAPE **/
  ESCAPE VARCHAR2(240);
  /** Unreserved Keyword Word ESTIMATE **/
  ESTIMATE VARCHAR2(240);
  /** Unreserved Keyword Word EVALNAME **/
  EVALNAME VARCHAR2(240);
  /** Unreserved Keyword Word EVALUATION **/
  EVALUATION VARCHAR2(240);
  /** Unreserved Keyword Word EVENTS **/
  EVENTS VARCHAR2(240);
  /** Unreserved Keyword Word EXCEPT **/
  EXCEPT VARCHAR2(240);
  /** Unreserved Keyword Word EXCEPTIONS **/
  EXCEPTIONS VARCHAR2(240);
  /** Unreserved Keyword Word EXCHANGE **/
  EXCHANGE VARCHAR2(240);
  /** Unreserved Keyword Word EXCLUDING **/
  EXCLUDING VARCHAR2(240);
  /** Unreserved Keyword Word EXECUTE **/
  EXECUTE VARCHAR2(240);
  /** Unreserved Keyword Word EXEMPT **/
  EXEMPT VARCHAR2(240);
  /** Unreserved Keyword Word EXPAND_GSET_TO_UNION **/
  EXPAND_GSET_TO_UNION VARCHAR2(240);
  /** Unreserved Keyword Word EXPIRE **/
  EXPIRE VARCHAR2(240);
  /** Unreserved Keyword Word EXPLAIN **/
  EXPLAIN VARCHAR2(240);
  /** Unreserved Keyword Word EXPLOSION **/
  EXPLOSION VARCHAR2(240);
  /** Unreserved Keyword Word EXPORT **/
  EXPORT VARCHAR2(240);
  /** Unreserved Keyword Word EXPR_CORR_CHECK **/
  EXPR_CORR_CHECK VARCHAR2(240);
  /** Unreserved Keyword Word EXTENDS **/
  EXTENDS VARCHAR2(240);
  /** Unreserved Keyword Word EXTENT **/
  EXTENT VARCHAR2(240);
  /** Unreserved Keyword Word EXTENTS **/
  EXTENTS VARCHAR2(240);
  /** Unreserved Keyword Word EXTERNAL **/
  EXTERNAL VARCHAR2(240);
  /** Unreserved Keyword Word EXTERNALLY **/
  EXTERNALLY VARCHAR2(240);
  /** Unreserved Keyword Word EXTRACT **/
  EXTRACT VARCHAR2(240);
  /** Unreserved Keyword Word FACT **/
  FACT VARCHAR2(240);
  /** Unreserved Keyword Word FAILED **/
  FAILED VARCHAR2(240);
  /** Unreserved Keyword Word FAILED_LOGIN_ATTEMPTS **/
  FAILED_LOGIN_ATTEMPTS VARCHAR2(240);
  /** Unreserved Keyword Word FAILGROUP **/
  FAILGROUP VARCHAR2(240);
  /** Unreserved Keyword Word FAST **/
  FAST VARCHAR2(240);
  /** Unreserved Keyword Word FBTSCAN **/
  FBTSCAN VARCHAR2(240);
  /** Unreserved Keyword Word FIC_CIV **/
  FIC_CIV VARCHAR2(240);
  /** Unreserved Keyword Word FIC_PIV **/
  FIC_PIV VARCHAR2(240);
  /** Unreserved Keyword Word FILE **/
  FILE VARCHAR2(240);
  /** Unreserved Keyword Word FILTER **/
  FILTER VARCHAR2(240);
  /** Unreserved Keyword Word FINAL **/
  FINAL VARCHAR2(240);
  /** Unreserved Keyword Word FINE **/
  FINE VARCHAR2(240);
  /** Unreserved Keyword Word FINISH **/
  FINISH VARCHAR2(240);
  /** Unreserved Keyword Word FIRST **/
  FIRST VARCHAR2(240);
  /** Unreserved Keyword Word FIRST_ROWS **/
  FIRST_ROWS VARCHAR2(240);
  /** Unreserved Keyword Word FLAGGER **/
  FLAGGER VARCHAR2(240);
  /** Unreserved Keyword Word FLASHBACK **/
  FLASHBACK VARCHAR2(240);
  /** Unreserved Keyword Word FLOB **/
  FLOB VARCHAR2(240);
  /** Unreserved Keyword Word FLUSH **/
  FLUSH VARCHAR2(240);
  /** Unreserved Keyword Word FOLLOWING **/
  FOLLOWING VARCHAR2(240);
  /** Unreserved Keyword Word FORCE **/
  "FORCE" VARCHAR2(240);
  /** Unreserved Keyword Word FORCE_XML_QUERY_REWRITE **/
  FORCE_XML_QUERY_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word FOREIGN **/
  FOREIGN VARCHAR2(240);
  /** Unreserved Keyword Word FREELIST **/
  FREELIST VARCHAR2(240);
  /** Unreserved Keyword Word FREELISTS **/
  FREELISTS VARCHAR2(240);
  /** Unreserved Keyword Word FREEPOOLS **/
  FREEPOOLS VARCHAR2(240);
  /** Unreserved Keyword Word FRESH **/
  FRESH VARCHAR2(240);
  /** Unreserved Keyword Word FULL **/
  FULL VARCHAR2(240);
  /** Unreserved Keyword Word FUNCTION **/
  "FUNCTION" VARCHAR2(240);
  /** Unreserved Keyword Word FUNCTIONS **/
  FUNCTIONS VARCHAR2(240);
  /** Unreserved Keyword Word G **/
  G VARCHAR2(240);
  /** Unreserved Keyword Word GATHER_PLAN_STATISTICS **/
  GATHER_PLAN_STATISTICS VARCHAR2(240);
  /** Unreserved Keyword Word GBY_CONC_ROLLUP **/
  GBY_CONC_ROLLUP VARCHAR2(240);
  /** Unreserved Keyword Word GENERATED **/
  GENERATED VARCHAR2(240);
  /** Unreserved Keyword Word GLOBAL **/
  GLOBAL VARCHAR2(240);
  /** Unreserved Keyword Word GLOBAL_NAME **/
  GLOBAL_NAME VARCHAR2(240);
  /** Unreserved Keyword Word GLOBAL_TOPIC_ENABLED **/
  GLOBAL_TOPIC_ENABLED VARCHAR2(240);
  /** Unreserved Keyword Word GLOBALLY **/
  GLOBALLY VARCHAR2(240);
  /** Unreserved Keyword Word GROUP_BY **/
  GROUP_BY VARCHAR2(240);
  /** Unreserved Keyword Word GROUPING **/
  GROUPING VARCHAR2(240);
  /** Unreserved Keyword Word GROUPS **/
  GROUPS VARCHAR2(240);
  /** Unreserved Keyword Word GUARANTEE **/
  GUARANTEE VARCHAR2(240);
  /** Unreserved Keyword Word GUARANTEED **/
  GUARANTEED VARCHAR2(240);
  /** Unreserved Keyword Word GUARD **/
  GUARD VARCHAR2(240);
  /** Unreserved Keyword Word HASH **/
  HASH VARCHAR2(240);
  /** Unreserved Keyword Word HASH_AJ **/
  HASH_AJ VARCHAR2(240);
  /** Unreserved Keyword Word HASH_SJ **/
  HASH_SJ VARCHAR2(240);
  /** Unreserved Keyword Word HASHKEYS **/
  HASHKEYS VARCHAR2(240);
  /** Unreserved Keyword Word HEADER **/
  HEADER VARCHAR2(240);
  /** Unreserved Keyword Word HEAP **/
  HEAP VARCHAR2(240);
  /** Unreserved Keyword Word HIERARCHY **/
  HIERARCHY VARCHAR2(240);
  /** Unreserved Keyword Word HIGH **/
  HIGH VARCHAR2(240);
  /** Unreserved Keyword Word HINTSET_BEGIN **/
  HINTSET_BEGIN VARCHAR2(240);
  /** Unreserved Keyword Word HINTSET_END **/
  HINTSET_END VARCHAR2(240);
  /** Unreserved Keyword Word HOUR **/
  HOUR VARCHAR2(240);
  /** Unreserved Keyword Word HWM_BROKERED **/
  HWM_BROKERED VARCHAR2(240);
  /** Unreserved Keyword Word ID **/
  ID VARCHAR2(240);
  /** Unreserved Keyword Word IDENTIFIER **/
  IDENTIFIER VARCHAR2(240);
  /** Unreserved Keyword Word IDENTITY **/
  IDENTITY VARCHAR2(240);
  /** Unreserved Keyword Word IDGENERATORS **/
  IDGENERATORS VARCHAR2(240);
  /** Unreserved Keyword Word IDLE_TIME **/
  IDLE_TIME VARCHAR2(240);
  /** Unreserved Keyword Word IF **/
   "IF" VARCHAR2(240);
  /** Unreserved Keyword Word IGNORE **/
  IGNORE VARCHAR2(240);
  /** Unreserved Keyword Word IGNORE_OPTIM_EMBEDDED_HINTS **/
  IGNORE_OPTIM_EMBEDDED_HINTS VARCHAR2(240);
  /** Unreserved Keyword Word IGNORE_WHERE_CLAUSE **/
  IGNORE_WHERE_CLAUSE VARCHAR2(240);
  /** Unreserved Keyword Word IMMEDIATE **/
  IMMEDIATE VARCHAR2(240);
  /** Unreserved Keyword Word IMPORT **/
  IMPORT VARCHAR2(240);
  /** Unreserved Keyword Word IN_MEMORY_METADATA **/
  IN_MEMORY_METADATA VARCHAR2(240);
  /** Unreserved Keyword Word INCLUDE_VERSION **/
  INCLUDE_VERSION VARCHAR2(240);
  /** Unreserved Keyword Word INCLUDING **/
  "INCLUDING" VARCHAR2(240);
  /** Unreserved Keyword Word INCREMENT **/
  INCREMENT VARCHAR2(240);
  /** Unreserved Keyword Word INCREMENTAL **/
  INCREMENTAL VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_ASC **/
  INDEX_ASC VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_COMBINE **/
  INDEX_COMBINE VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_DESC **/
  INDEX_DESC VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_FFS **/
  INDEX_FFS VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_FILTER **/
  INDEX_FILTER VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_JOIN **/
  INDEX_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_ROWS **/
  INDEX_ROWS VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_RRS **/
  INDEX_RRS VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_RS **/
  INDEX_RS VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_RS_ASC **/
  INDEX_RS_ASC VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_RS_DESC **/
  INDEX_RS_DESC VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_SCAN **/
  INDEX_SCAN VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_SKIP_SCAN **/
  INDEX_SKIP_SCAN VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_SS **/
  INDEX_SS VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_SS_ASC **/
  INDEX_SS_ASC VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_SS_DESC **/
  INDEX_SS_DESC VARCHAR2(240);
  /** Unreserved Keyword Word INDEX_STATS **/
  INDEX_STATS VARCHAR2(240);
  /** Unreserved Keyword Word INDEXED **/
  INDEXED VARCHAR2(240);
  /** Unreserved Keyword Word INDEXES **/
   "INDEXES" VARCHAR2(240);
  /** Unreserved Keyword Word INDEXTYPE **/
  INDEXTYPE VARCHAR2(240);
  /** Unreserved Keyword Word INDEXTYPES **/
  INDEXTYPES VARCHAR2(240);
  /** Unreserved Keyword Word INDICATOR **/
  INDICATOR VARCHAR2(240);
  /** Unreserved Keyword Word INFINITE **/
  INFINITE VARCHAR2(240);
  /** Unreserved Keyword Word INFORMATIONAL **/
  INFORMATIONAL VARCHAR2(240);
  /** Unreserved Keyword Word INITIAL **/
  INITIAL VARCHAR2(240);
  /** Unreserved Keyword Word INITIALIZED **/
  INITIALIZED VARCHAR2(240);
  /** Unreserved Keyword Word INITIALLY **/
  INITIALLY VARCHAR2(240);
  /** Unreserved Keyword Word INITRANS **/
  INITRANS VARCHAR2(240);
  /** Unreserved Keyword Word INLINE **/
  INLINE VARCHAR2(240);
  /** Unreserved Keyword Word INLINE_XMLTYPE_NT **/
  INLINE_XMLTYPE_NT VARCHAR2(240);
  /** Unreserved Keyword Word INNER **/
  INNER VARCHAR2(240);
  /** Unreserved Keyword Word INSTANCE **/
  INSTANCE VARCHAR2(240);
  /** Unreserved Keyword Word INSTANCES **/
  INSTANCES VARCHAR2(240);
  /** Unreserved Keyword Word INSTANTIABLE **/
  INSTANTIABLE VARCHAR2(240);
  /** Unreserved Keyword Word INSTANTLY **/
  INSTANTLY VARCHAR2(240);
  /** Unreserved Keyword Word INSTEAD **/
  INSTEAD VARCHAR2(240);
  /** Unreserved Keyword Word INT **/
  INT VARCHAR2(240);
  /** Unreserved Keyword Word INTERMEDIATE **/
  INTERMEDIATE VARCHAR2(240);
  /** Unreserved Keyword Word INTERNAL_CONVERT **/
  INTERNAL_CONVERT VARCHAR2(240);
  /** Unreserved Keyword Word INTERNAL_USE **/
  INTERNAL_USE VARCHAR2(240);
  /** Unreserved Keyword Word INTERPRETED **/
  INTERPRETED VARCHAR2(240);
  /** Unreserved Keyword Word INTERVAL **/
  INTERVAL VARCHAR2(240);
  /** Unreserved Keyword Word INVALIDATE **/
  INVALIDATE VARCHAR2(240);
  /** Unreserved Keyword Word ISOLATION **/
  ISOLATION VARCHAR2(240);
  /** Unreserved Keyword Word ISOLATION_LEVEL **/
  ISOLATION_LEVEL VARCHAR2(240);
  /** Unreserved Keyword Word ITERATE **/
  ITERATE VARCHAR2(240);
  /** Unreserved Keyword Word ITERATION_NUMBER **/
  ITERATION_NUMBER VARCHAR2(240);
  /** Unreserved Keyword Word JAVA **/
  JAVA VARCHAR2(240);
  /** Unreserved Keyword Word JOB **/
  JOB VARCHAR2(240);
  /** Unreserved Keyword Word JOIN **/
  JOIN VARCHAR2(240);
  /** Unreserved Keyword Word K **/
  K VARCHAR2(240);
  /** Unreserved Keyword Word KEEP **/
  KEEP VARCHAR2(240);
  /** Unreserved Keyword Word KERBEROS **/
  KERBEROS VARCHAR2(240);
  /** Unreserved Keyword Word KEY **/
  KEY VARCHAR2(240);
  /** Unreserved Keyword Word KEY_LENGTH **/
  KEY_LENGTH VARCHAR2(240);
  /** Unreserved Keyword Word KEYS **/
  KEYS VARCHAR2(240);
  /** Unreserved Keyword Word KEYSIZE **/
  KEYSIZE VARCHAR2(240);
  /** Unreserved Keyword Word KILL **/
  KILL VARCHAR2(240);
  /** Unreserved Keyword Word LAST **/
  LAST VARCHAR2(240);
  /** Unreserved Keyword Word LATERAL **/
  LATERAL VARCHAR2(240);
  /** Unreserved Keyword Word LAYER **/
  LAYER VARCHAR2(240);
  /** Unreserved Keyword Word LDAP_REG_SYNC_INTERVAL **/
  LDAP_REG_SYNC_INTERVAL VARCHAR2(240);
  /** Unreserved Keyword Word LDAP_REGISTRATION **/
  LDAP_REGISTRATION VARCHAR2(240);
  /** Unreserved Keyword Word LDAP_REGISTRATION_ENABLED **/
  LDAP_REGISTRATION_ENABLED VARCHAR2(240);
  /** Unreserved Keyword Word LEADING **/
  LEADING VARCHAR2(240);
  /** Unreserved Keyword Word LEFT **/
  LEFT VARCHAR2(240);
  /** Unreserved Keyword Word LENGTH **/
  LENGTH VARCHAR2(240);
  /** Unreserved Keyword Word LESS **/
  LESS VARCHAR2(240);
  /** Unreserved Keyword Word LEVEL **/
  LEVEL VARCHAR2(240);
  /** Unreserved Keyword Word LEVELS **/
  LEVELS VARCHAR2(240);
  /** Unreserved Keyword Word LIBRARY **/
  LIBRARY VARCHAR2(240);
  /** Unreserved Keyword Word LIKE_EXPAND **/
  LIKE_EXPAND VARCHAR2(240);
  /** Unreserved Keyword Word LIKE2 **/
  LIKE2 VARCHAR2(240);
  /** Unreserved Keyword Word LIKE4 **/
  LIKE4 VARCHAR2(240);
  /** Unreserved Keyword Word LIKEC **/
  LIKEC VARCHAR2(240);
  /** Unreserved Keyword Word LIMIT **/
  LIMIT VARCHAR2(240);
  /** Unreserved Keyword Word LINK **/
  LINK VARCHAR2(240);
  /** Unreserved Keyword Word LIST **/
  LIST VARCHAR2(240);
  /** Unreserved Keyword Word LOB **/
  LOB VARCHAR2(240);
  /** Unreserved Keyword Word LOCAL **/
  LOCAL VARCHAR2(240);
  /** Unreserved Keyword Word LOCAL_INDEXES **/
  LOCAL_INDEXES VARCHAR2(240);
  /** Unreserved Keyword Word LOCALTIME **/
  LOCALTIME VARCHAR2(240);
  /** Unreserved Keyword Word LOCALTIMESTAMP **/
  LOCALTIMESTAMP VARCHAR2(240);
  /** Unreserved Keyword Word LOCATION **/
  LOCATION VARCHAR2(240);
  /** Unreserved Keyword Word LOCATOR **/
  LOCATOR VARCHAR2(240);
  /** Unreserved Keyword Word LOCKED **/
  LOCKED VARCHAR2(240);
  /** Unreserved Keyword Word LOG **/
  LOG VARCHAR2(240);
  /** Unreserved Keyword Word LOGFILE **/
  LOGFILE VARCHAR2(240);
  /** Unreserved Keyword Word LOGGING **/
  LOGGING VARCHAR2(240);
  /** Unreserved Keyword Word LOGICAL **/
  LOGICAL VARCHAR2(240);
  /** Unreserved Keyword Word LOGICAL_READS_PER_CALL **/
  LOGICAL_READS_PER_CALL VARCHAR2(240);
  /** Unreserved Keyword Word LOGICAL_READS_PER_SESSION **/
  LOGICAL_READS_PER_SESSION VARCHAR2(240);
  /** Unreserved Keyword Word LOGOFF **/
  LOGOFF VARCHAR2(240);
  /** Unreserved Keyword Word LOGON **/
  LOGON VARCHAR2(240);
  /** Unreserved Keyword Word M **/
  M VARCHAR2(240);
  /** Unreserved Keyword Word MAIN **/
  MAIN VARCHAR2(240);
  /** Unreserved Keyword Word MANAGE **/
  MANAGE VARCHAR2(240);
  /** Unreserved Keyword Word MANAGED **/
  MANAGED VARCHAR2(240);
  /** Unreserved Keyword Word MANAGEMENT **/
  MANAGEMENT VARCHAR2(240);
  /** Unreserved Keyword Word MANUAL **/
  MANUAL VARCHAR2(240);
  /** Unreserved Keyword Word MAP **/
  MAP VARCHAR2(240);
  /** Unreserved Keyword Word MAPPING **/
  MAPPING VARCHAR2(240);
  /** Unreserved Keyword Word MASTER **/
  MASTER VARCHAR2(240);
  /** Unreserved Keyword Word MATCHED **/
  MATCHED VARCHAR2(240);
  /** Unreserved Keyword Word MATERIALIZE **/
  MATERIALIZE VARCHAR2(240);
  /** Unreserved Keyword Word MATERIALIZED **/
  MATERIALIZED VARCHAR2(240);
  /** Unreserved Keyword Word MAX **/
  MAX VARCHAR2(240);
  /** Unreserved Keyword Word MAXARCHLOGS **/
  MAXARCHLOGS VARCHAR2(240);
  /** Unreserved Keyword Word MAXDATAFILES **/
  MAXDATAFILES VARCHAR2(240);
  /** Unreserved Keyword Word MAXEXTENTS **/
  MAXEXTENTS VARCHAR2(240);
  /** Unreserved Keyword Word MAXIMIZE **/
  MAXIMIZE VARCHAR2(240);
  /** Unreserved Keyword Word MAXINSTANCES **/
  MAXINSTANCES VARCHAR2(240);
  /** Unreserved Keyword Word MAXLOGFILES **/
  MAXLOGFILES VARCHAR2(240);
  /** Unreserved Keyword Word MAXLOGHISTORY **/
  MAXLOGHISTORY VARCHAR2(240);
  /** Unreserved Keyword Word MAXLOGMEMBERS **/
  MAXLOGMEMBERS VARCHAR2(240);
  /** Unreserved Keyword Word MAXSIZE **/
  MAXSIZE VARCHAR2(240);
  /** Unreserved Keyword Word MAXTRANS **/
  MAXTRANS VARCHAR2(240);
  /** Unreserved Keyword Word MAXVALUE **/
  MAXVALUE VARCHAR2(240);
  /** Unreserved Keyword Word MEASURES **/
  MEASURES VARCHAR2(240);
  /** Unreserved Keyword Word MEMBER **/
  MEMBER VARCHAR2(240);
  /** Unreserved Keyword Word MEMORY **/
  MEMORY VARCHAR2(240);
  /** Unreserved Keyword Word MERGE **/
  MERGE VARCHAR2(240);
  /** Unreserved Keyword Word MERGE_AJ **/
  MERGE_AJ VARCHAR2(240);
  /** Unreserved Keyword Word MERGE_CONST_ON **/
  MERGE_CONST_ON VARCHAR2(240);
  /** Unreserved Keyword Word MERGE_SJ **/
  MERGE_SJ VARCHAR2(240);
  /** Unreserved Keyword Word METHOD **/
  METHOD VARCHAR2(240);
  /** Unreserved Keyword Word MIGRATE **/
  MIGRATE VARCHAR2(240);
  /** Unreserved Keyword Word MIN **/
  MIN VARCHAR2(240);
  /** Unreserved Keyword Word MINEXTENTS **/
  MINEXTENTS VARCHAR2(240);
  /** Unreserved Keyword Word MINIMIZE **/
  MINIMIZE VARCHAR2(240);
  /** Unreserved Keyword Word MINIMUM **/
  MINIMUM VARCHAR2(240);
  /** Unreserved Keyword Word MINUS_NULL **/
  MINUS_NULL VARCHAR2(240);
  /** Unreserved Keyword Word MINUTE **/
  MINUTE VARCHAR2(240);
  /** Unreserved Keyword Word MINVALUE **/
  MINVALUE VARCHAR2(240);
  /** Unreserved Keyword Word MIRROR **/
  MIRROR VARCHAR2(240);
  /** Unreserved Keyword Word MLSLABEL **/
  MLSLABEL VARCHAR2(240);
  /** Unreserved Keyword Word MODEL **/
  MODEL VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_COMPILE_SUBQUERY **/
  MODEL_COMPILE_SUBQUERY VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_DONTVERIFY_UNIQUENESS **/
  MODEL_DONTVERIFY_UNIQUENESS VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_DYNAMIC_SUBQUERY **/
  MODEL_DYNAMIC_SUBQUERY VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_MIN_ANALYSIS **/
  MODEL_MIN_ANALYSIS VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_NO_ANALYSIS **/
  MODEL_NO_ANALYSIS VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_PBY **/
  MODEL_PBY VARCHAR2(240);
  /** Unreserved Keyword Word MODEL_PUSH_REF **/
  MODEL_PUSH_REF VARCHAR2(240);
  /** Unreserved Keyword Word MODIFY **/
  MODIFY VARCHAR2(240);
  /** Unreserved Keyword Word MONITORING **/
  MONITORING VARCHAR2(240);
  /** Unreserved Keyword Word MONTH **/
  MONTH VARCHAR2(240);
  /** Unreserved Keyword Word MOUNT **/
  MOUNT VARCHAR2(240);
  /** Unreserved Keyword Word MOVE **/
  MOVE VARCHAR2(240);
  /** Unreserved Keyword Word MOVEMENT **/
  MOVEMENT VARCHAR2(240);
  /** Unreserved Keyword Word MULTISET **/
  MULTISET VARCHAR2(240);
  /** Unreserved Keyword Word MV_MERGE **/
  MV_MERGE VARCHAR2(240);
  /** Unreserved Keyword Word NAME **/
  NAME VARCHAR2(240);
  /** Unreserved Keyword Word NAMED **/
  NAMED VARCHAR2(240);
  /** Unreserved Keyword Word NAN **/
  NAN VARCHAR2(240);
  /** Unreserved Keyword Word NATIONAL **/
  NATIONAL VARCHAR2(240);
  /** Unreserved Keyword Word NATIVE **/
  NATIVE VARCHAR2(240);
  /** Unreserved Keyword Word NATIVE_FULL_OUTER_JOIN **/
  NATIVE_FULL_OUTER_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word NATURAL **/
  NATURAL VARCHAR2(240);
  /** Unreserved Keyword Word NAV **/
  NAV VARCHAR2(240);
  /** Unreserved Keyword Word NCHAR **/
  NCHAR VARCHAR2(240);
  /** Unreserved Keyword Word NCHAR_CS **/
  NCHAR_CS VARCHAR2(240);
  /** Unreserved Keyword Word NCLOB **/
  NCLOB VARCHAR2(240);
  /** Unreserved Keyword Word NEEDED **/
  NEEDED VARCHAR2(240);
  /** Unreserved Keyword Word NESTED **/
  NESTED VARCHAR2(240);
  /** Unreserved Keyword Word NESTED_TABLE_FAST_INSERT **/
  NESTED_TABLE_FAST_INSERT VARCHAR2(240);
  /** Unreserved Keyword Word NESTED_TABLE_GET_REFS **/
  NESTED_TABLE_GET_REFS VARCHAR2(240);
  /** Unreserved Keyword Word NESTED_TABLE_ID **/
  NESTED_TABLE_ID VARCHAR2(240);
  /** Unreserved Keyword Word NESTED_TABLE_SET_REFS **/
  NESTED_TABLE_SET_REFS VARCHAR2(240);
  /** Unreserved Keyword Word NESTED_TABLE_SET_SETID **/
  NESTED_TABLE_SET_SETID VARCHAR2(240);
  /** Unreserved Keyword Word NETWORK **/
  NETWORK VARCHAR2(240);
  /** Unreserved Keyword Word NEVER **/
  NEVER VARCHAR2(240);
  /** Unreserved Keyword Word NEW **/
  NEW VARCHAR2(240);
  /** Unreserved Keyword Word NEXT **/
  NEXT VARCHAR2(240);
  /** Unreserved Keyword Word NL_AJ **/
  NL_AJ VARCHAR2(240);
  /** Unreserved Keyword Word NL_SJ **/
  NL_SJ VARCHAR2(240);
  /** Unreserved Keyword Word NLS_CALENDAR **/
  NLS_CALENDAR VARCHAR2(240);
  /** Unreserved Keyword Word NLS_CHARACTERSET **/
  NLS_CHARACTERSET VARCHAR2(240);
  /** Unreserved Keyword Word NLS_COMP **/
  NLS_COMP VARCHAR2(240);
  /** Unreserved Keyword Word NLS_CURRENCY **/
  NLS_CURRENCY VARCHAR2(240);
  /** Unreserved Keyword Word NLS_DATE_FORMAT **/
  NLS_DATE_FORMAT VARCHAR2(240);
  /** Unreserved Keyword Word NLS_DATE_LANGUAGE **/
  NLS_DATE_LANGUAGE VARCHAR2(240);
  /** Unreserved Keyword Word NLS_ISO_CURRENCY **/
  NLS_ISO_CURRENCY VARCHAR2(240);
  /** Unreserved Keyword Word NLS_LANG **/
  NLS_LANG VARCHAR2(240);
  /** Unreserved Keyword Word NLS_LANGUAGE **/
  NLS_LANGUAGE VARCHAR2(240);
  /** Unreserved Keyword Word NLS_LENGTH_SEMANTICS **/
  NLS_LENGTH_SEMANTICS VARCHAR2(240);
  /** Unreserved Keyword Word NLS_NCHAR_CONV_EXCP **/
  NLS_NCHAR_CONV_EXCP VARCHAR2(240);
  /** Unreserved Keyword Word NLS_NUMERIC_CHARACTERS **/
  NLS_NUMERIC_CHARACTERS VARCHAR2(240);
  /** Unreserved Keyword Word NLS_SORT **/
  NLS_SORT VARCHAR2(240);
  /** Unreserved Keyword Word NLS_SPECIAL_CHARS **/
  NLS_SPECIAL_CHARS VARCHAR2(240);
  /** Unreserved Keyword Word NLS_TERRITORY **/
  NLS_TERRITORY VARCHAR2(240);
  /** Unreserved Keyword Word NO **/
  NO VARCHAR2(240);
  /** Unreserved Keyword Word NO_ACCESS **/
  NO_ACCESS VARCHAR2(240);
  /** Unreserved Keyword Word NO_BASETABLE_MULTIMV_REWRITE **/
  NO_BASETABLE_MULTIMV_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word NO_BUFFER **/
  NO_BUFFER VARCHAR2(240);
  /** Unreserved Keyword Word NO_CARTESIAN **/
  NO_CARTESIAN VARCHAR2(240);
  /** Unreserved Keyword Word NO_CONNECT_BY_COST_BASED **/
  NO_CONNECT_BY_COST_BASED VARCHAR2(240);
  /** Unreserved Keyword Word NO_CONNECT_BY_FILTERING **/
  NO_CONNECT_BY_FILTERING VARCHAR2(240);
  /** Unreserved Keyword Word NO_CPU_COSTING **/
  NO_CPU_COSTING VARCHAR2(240);
  /** Unreserved Keyword Word NO_ELIMINATE_JOIN **/
  NO_ELIMINATE_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word NO_ELIMINATE_OBY **/
  NO_ELIMINATE_OBY VARCHAR2(240);
  /** Unreserved Keyword Word NO_ELIMINATE_OUTER_JOIN **/
  NO_ELIMINATE_OUTER_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word NO_EXPAND **/
  NO_EXPAND VARCHAR2(240);
  /** Unreserved Keyword Word NO_EXPAND_GSET_TO_UNION **/
  NO_EXPAND_GSET_TO_UNION VARCHAR2(240);
  /** Unreserved Keyword Word NO_FACT **/
  NO_FACT VARCHAR2(240);
  /** Unreserved Keyword Word NO_FILTERING **/
  NO_FILTERING VARCHAR2(240);
  /** Unreserved Keyword Word NO_INDEX **/
  NO_INDEX VARCHAR2(240);
  /** Unreserved Keyword Word NO_INDEX_FFS **/
  NO_INDEX_FFS VARCHAR2(240);
  /** Unreserved Keyword Word NO_INDEX_RS **/
  NO_INDEX_RS VARCHAR2(240);
  /** Unreserved Keyword Word NO_INDEX_SS **/
  NO_INDEX_SS VARCHAR2(240);
  /** Unreserved Keyword Word NO_MERGE **/
  NO_MERGE VARCHAR2(240);
  /** Unreserved Keyword Word NO_MODEL_PUSH_REF **/
  NO_MODEL_PUSH_REF VARCHAR2(240);
  /** Unreserved Keyword Word NO_MONITORING **/
  NO_MONITORING VARCHAR2(240);
  /** Unreserved Keyword Word NO_MULTIMV_REWRITE **/
  NO_MULTIMV_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word NO_NATIVE_FULL_OUTER_JOIN **/
  NO_NATIVE_FULL_OUTER_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word NO_ORDER_ROLLUPS **/
  NO_ORDER_ROLLUPS VARCHAR2(240);
  /** Unreserved Keyword Word NO_PARALLEL **/
  NO_PARALLEL VARCHAR2(240);
  /** Unreserved Keyword Word NO_PARALLEL_INDEX **/
  NO_PARALLEL_INDEX VARCHAR2(240);
  /** Unreserved Keyword Word NO_PARTIAL_COMMIT **/
  NO_PARTIAL_COMMIT VARCHAR2(240);
  /** Unreserved Keyword Word NO_PRUNE_GSETS **/
  NO_PRUNE_GSETS VARCHAR2(240);
  /** Unreserved Keyword Word NO_PULL_PRED **/
  NO_PULL_PRED VARCHAR2(240);
  /** Unreserved Keyword Word NO_PUSH_PRED **/
  NO_PUSH_PRED VARCHAR2(240);
  /** Unreserved Keyword Word NO_PUSH_SUBQ **/
  NO_PUSH_SUBQ VARCHAR2(240);
  /** Unreserved Keyword Word NO_PX_JOIN_FILTER **/
  NO_PX_JOIN_FILTER VARCHAR2(240);
  /** Unreserved Keyword Word NO_QKN_BUFF **/
  NO_QKN_BUFF VARCHAR2(240);
  /** Unreserved Keyword Word NO_QUERY_TRANSFORMATION **/
  NO_QUERY_TRANSFORMATION VARCHAR2(240);
  /** Unreserved Keyword Word NO_REF_CASCADE **/
  NO_REF_CASCADE VARCHAR2(240);
  /** Unreserved Keyword Word NO_REWRITE **/
  NO_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word NO_SEMIJOIN **/
  NO_SEMIJOIN VARCHAR2(240);
  /** Unreserved Keyword Word NO_SET_TO_JOIN **/
  NO_SET_TO_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word NO_SQL_TUNE **/
  NO_SQL_TUNE VARCHAR2(240);
  /** Unreserved Keyword Word NO_STAR_TRANSFORMATION **/
  NO_STAR_TRANSFORMATION VARCHAR2(240);
  /** Unreserved Keyword Word NO_STATS_GSETS **/
  NO_STATS_GSETS VARCHAR2(240);
  /** Unreserved Keyword Word NO_SWAP_JOIN_INPUTS **/
  NO_SWAP_JOIN_INPUTS VARCHAR2(240);
  /** Unreserved Keyword Word NO_TEMP_TABLE **/
  NO_TEMP_TABLE VARCHAR2(240);
  /** Unreserved Keyword Word NO_UNNEST **/
  NO_UNNEST VARCHAR2(240);
  /** Unreserved Keyword Word NO_USE_HASH **/
  NO_USE_HASH VARCHAR2(240);
  /** Unreserved Keyword Word NO_USE_HASH_AGGREGATION **/
  NO_USE_HASH_AGGREGATION VARCHAR2(240);
  /** Unreserved Keyword Word NO_USE_MERGE **/
  NO_USE_MERGE VARCHAR2(240);
  /** Unreserved Keyword Word NO_USE_NL **/
  NO_USE_NL VARCHAR2(240);
  /** Unreserved Keyword Word NO_XML_DML_REWRITE **/
  NO_XML_DML_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word NO_XML_QUERY_REWRITE **/
  NO_XML_QUERY_REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word NOAPPEND **/
  NOAPPEND VARCHAR2(240);
  /** Unreserved Keyword Word NOARCHIVELOG **/
  NOARCHIVELOG VARCHAR2(240);
  /** Unreserved Keyword Word NOAUDIT **/
  NOAUDIT VARCHAR2(240);
  /** Unreserved Keyword Word NOCACHE **/
  NOCACHE VARCHAR2(240);
  /** Unreserved Keyword Word NOCPU_COSTING **/
  NOCPU_COSTING VARCHAR2(240);
  /** Unreserved Keyword Word NOCYCLE **/
  NOCYCLE VARCHAR2(240);
  /** Unreserved Keyword Word NODELAY **/
  NODELAY VARCHAR2(240);
  /** Unreserved Keyword Word NOFORCE **/
  NOFORCE VARCHAR2(240);
  /** Unreserved Keyword Word NOGUARANTEE **/
  NOGUARANTEE VARCHAR2(240);
  /** Unreserved Keyword Word NOLOGGING **/
  NOLOGGING VARCHAR2(240);
  /** Unreserved Keyword Word NOMAPPING **/
  NOMAPPING VARCHAR2(240);
  /** Unreserved Keyword Word NOMAXVALUE **/
  NOMAXVALUE VARCHAR2(240);
  /** Unreserved Keyword Word NOMINIMIZE **/
  NOMINIMIZE VARCHAR2(240);
  /** Unreserved Keyword Word NOMINVALUE **/
  NOMINVALUE VARCHAR2(240);
  /** Unreserved Keyword Word NOMONITORING **/
  NOMONITORING VARCHAR2(240);
  /** Unreserved Keyword Word NONE **/
  NONE VARCHAR2(240);
  /** Unreserved Keyword Word NOORDER **/
  NOORDER VARCHAR2(240);
  /** Unreserved Keyword Word NOOVERRIDE **/
  NOOVERRIDE VARCHAR2(240);
  /** Unreserved Keyword Word NOPARALLEL **/
  NOPARALLEL VARCHAR2(240);
  /** Unreserved Keyword Word NOPARALLEL_INDEX **/
  NOPARALLEL_INDEX VARCHAR2(240);
  /** Unreserved Keyword Word NORELY **/
  NORELY VARCHAR2(240);
  /** Unreserved Keyword Word NOREPAIR **/
  NOREPAIR VARCHAR2(240);
  /** Unreserved Keyword Word NORESETLOGS **/
  NORESETLOGS VARCHAR2(240);
  /** Unreserved Keyword Word NOREVERSE **/
  NOREVERSE VARCHAR2(240);
  /** Unreserved Keyword Word NOREWRITE **/
  NOREWRITE VARCHAR2(240);
  /** Unreserved Keyword Word NORMAL **/
  NORMAL VARCHAR2(240);
  /** Unreserved Keyword Word NOROWDEPENDENCIES **/
  NOROWDEPENDENCIES VARCHAR2(240);
  /** Unreserved Keyword Word NOSEGMENT **/
  NOSEGMENT VARCHAR2(240);
  /** Unreserved Keyword Word NOSORT **/
  NOSORT VARCHAR2(240);
  /** Unreserved Keyword Word NOSTRICT **/
  NOSTRICT VARCHAR2(240);
  /** Unreserved Keyword Word NOSWITCH **/
  NOSWITCH VARCHAR2(240);
  /** Unreserved Keyword Word NOTHING **/
  NOTHING VARCHAR2(240);
  /** Unreserved Keyword Word NOTIFICATION **/
  NOTIFICATION VARCHAR2(240);
  /** Unreserved Keyword Word NOVALIDATE **/
  NOVALIDATE VARCHAR2(240);
  /** Unreserved Keyword Word NULLS **/
  NULLS VARCHAR2(240);
  /** Unreserved Keyword Word NUM_INDEX_KEYS **/
  NUM_INDEX_KEYS VARCHAR2(240);
  /** Unreserved Keyword Word NUMERIC **/
  NUMERIC VARCHAR2(240);
  /** Unreserved Keyword Word NVARCHAR2 **/
  NVARCHAR2 VARCHAR2(240);
  /** Unreserved Keyword Word OBJECT **/
  OBJECT VARCHAR2(240);
  /** Unreserved Keyword Word OBJNO **/
  OBJNO VARCHAR2(240);
  /** Unreserved Keyword Word OBJNO_REUSE **/
  OBJNO_REUSE VARCHAR2(240);
  /** Unreserved Keyword Word OFF **/
  OFF VARCHAR2(240);
  /** Unreserved Keyword Word OFFLINE **/
  OFFLINE VARCHAR2(240);
  /** Unreserved Keyword Word OID **/
  OID VARCHAR2(240);
  /** Unreserved Keyword Word OIDINDEX **/
  OIDINDEX VARCHAR2(240);
  /** Unreserved Keyword Word OLD **/
  OLD VARCHAR2(240);
  /** Unreserved Keyword Word OLD_PUSH_PRED **/
  OLD_PUSH_PRED VARCHAR2(240);
  /** Unreserved Keyword Word ONLINE **/
  ONLINE VARCHAR2(240);
  /** Unreserved Keyword Word ONLY **/
  ONLY VARCHAR2(240);
  /** Unreserved Keyword Word OPAQUE **/
  OPAQUE VARCHAR2(240);
  /** Unreserved Keyword Word OPAQUE_TRANSFORM **/
  OPAQUE_TRANSFORM VARCHAR2(240);
  /** Unreserved Keyword Word OPAQUE_XCANONICAL **/
  OPAQUE_XCANONICAL VARCHAR2(240);
  /** Unreserved Keyword Word OPCODE **/
  OPCODE VARCHAR2(240);
  /** Unreserved Keyword Word OPEN **/
  OPEN VARCHAR2(240);
  /** Unreserved Keyword Word OPERATOR **/
  OPERATOR VARCHAR2(240);
  /** Unreserved Keyword Word OPT_ESTIMATE **/
  OPT_ESTIMATE VARCHAR2(240);
  /** Unreserved Keyword Word OPT_PARAM **/
  OPT_PARAM VARCHAR2(240);
  /** Unreserved Keyword Word OPTIMAL **/
  OPTIMAL VARCHAR2(240);
  /** Unreserved Keyword Word OPTIMIZER_FEATURES_ENABLE **/
  OPTIMIZER_FEATURES_ENABLE VARCHAR2(240);
  /** Unreserved Keyword Word OPTIMIZER_GOAL **/
  OPTIMIZER_GOAL VARCHAR2(240);
  /** Unreserved Keyword Word OR_EXPAND **/
  OR_EXPAND VARCHAR2(240);
  /** Unreserved Keyword Word ORA_ROWSCN **/
  ORA_ROWSCN VARCHAR2(240);
  /** Unreserved Keyword Word ORDERED **/
  ORDERED VARCHAR2(240);
  /** Unreserved Keyword Word ORDERED_PREDICATES **/
  ORDERED_PREDICATES VARCHAR2(240);
  /** Unreserved Keyword Word ORDINALITY **/
  ORDINALITY VARCHAR2(240);
  /** Unreserved Keyword Word ORGANIZATION **/
  ORGANIZATION VARCHAR2(240);
  /** Unreserved Keyword Word OUT_OF_LINE **/
  OUT_OF_LINE VARCHAR2(240);
  /** Unreserved Keyword Word OUTER **/
  OUTER VARCHAR2(240);
  /** Unreserved Keyword Word OUTLINE **/
  OUTLINE VARCHAR2(240);
  /** Unreserved Keyword Word OUTLINE_LEAF **/
  OUTLINE_LEAF VARCHAR2(240);
  /** Unreserved Keyword Word OVER **/
  OVER VARCHAR2(240);
  /** Unreserved Keyword Word OVERFLOW **/
  OVERFLOW VARCHAR2(240);
  /** Unreserved Keyword Word OVERFLOW_NOMOVE **/
  OVERFLOW_NOMOVE VARCHAR2(240);
  /** Unreserved Keyword Word OVERLAPS **/
   "OVERLAPS" VARCHAR2(240);
  /** Unreserved Keyword Word OVERRIDING **/
  OVERRIDING VARCHAR2(240);
  /** Unreserved Keyword Word OWN **/
  OWN VARCHAR2(240);
  /** Unreserved Keyword Word P **/
  P VARCHAR2(240);
  /** Unreserved Keyword Word PACKAGE **/
  PACKAGE VARCHAR2(240);
  /** Unreserved Keyword Word PACKAGES **/
  PACKAGES VARCHAR2(240);
  /** Unreserved Keyword Word PARALLEL **/
  PARALLEL VARCHAR2(240);
  /** Unreserved Keyword Word PARALLEL_INDEX **/
  PARALLEL_INDEX VARCHAR2(240);
  /** Unreserved Keyword Word PARAMETERS **/
  PARAMETERS VARCHAR2(240);
  /** Unreserved Keyword Word PARENT **/
  PARENT VARCHAR2(240);
  /** Unreserved Keyword Word PARITY **/
  PARITY VARCHAR2(240);
  /** Unreserved Keyword Word PARTIALLY **/
  PARTIALLY VARCHAR2(240);
  /** Unreserved Keyword Word PARTITION **/
  PARTITION VARCHAR2(240);
  /** Unreserved Keyword Word PARTITION_HASH **/
  PARTITION_HASH VARCHAR2(240);
  /** Unreserved Keyword Word PARTITION_LIST **/
  PARTITION_LIST VARCHAR2(240);
  /** Unreserved Keyword Word PARTITION_RANGE **/
  PARTITION_RANGE VARCHAR2(240);
  /** Unreserved Keyword Word PARTITIONS **/
  PARTITIONS VARCHAR2(240);
  /** Unreserved Keyword Word PASSING **/
  PASSING VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD **/
  PASSWORD VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD_GRACE_TIME **/
  PASSWORD_GRACE_TIME VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD_LIFE_TIME **/
  PASSWORD_LIFE_TIME VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD_LOCK_TIME **/
  PASSWORD_LOCK_TIME VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD_REUSE_MAX **/
  PASSWORD_REUSE_MAX VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD_REUSE_TIME **/
  PASSWORD_REUSE_TIME VARCHAR2(240);
  /** Unreserved Keyword Word PASSWORD_VERIFY_FUNCTION **/
  PASSWORD_VERIFY_FUNCTION VARCHAR2(240);
  /** Unreserved Keyword Word PATH **/
  PATH VARCHAR2(240);
  /** Unreserved Keyword Word PATHS **/
  PATHS VARCHAR2(240);
  /** Unreserved Keyword Word PCTINCREASE **/
  PCTINCREASE VARCHAR2(240);
  /** Unreserved Keyword Word PCTTHRESHOLD **/
  PCTTHRESHOLD VARCHAR2(240);
  /** Unreserved Keyword Word PCTUSED **/
  PCTUSED VARCHAR2(240);
  /** Unreserved Keyword Word PCTVERSION **/
  PCTVERSION VARCHAR2(240);
  /** Unreserved Keyword Word PERCENT **/
  PERCENT VARCHAR2(240);
  /** Unreserved Keyword Word PERFORMANCE **/
  PERFORMANCE VARCHAR2(240);
  /** Unreserved Keyword Word PERMANENT **/
  PERMANENT VARCHAR2(240);
  /** Unreserved Keyword Word PFILE **/
  PFILE VARCHAR2(240);
  /** Unreserved Keyword Word PHYSICAL **/
  PHYSICAL VARCHAR2(240);
  /** Unreserved Keyword Word PIV_GB **/
  PIV_GB VARCHAR2(240);
  /** Unreserved Keyword Word PIV_SSF **/
  PIV_SSF VARCHAR2(240);
  /** Unreserved Keyword Word PLAN **/
  PLAN VARCHAR2(240);
  /** Unreserved Keyword Word PLSQL_CCFLAGS **/
  PLSQL_CCFLAGS VARCHAR2(240);
  /** Unreserved Keyword Word PLSQL_CODE_TYPE **/
  PLSQL_CODE_TYPE VARCHAR2(240);
  /** Unreserved Keyword Word PLSQL_DEBUG **/
  PLSQL_DEBUG VARCHAR2(240);
  /** Unreserved Keyword Word PLSQL_OPTIMIZE_LEVEL **/
  PLSQL_OPTIMIZE_LEVEL VARCHAR2(240);
  /** Unreserved Keyword Word PLSQL_WARNINGS **/
  PLSQL_WARNINGS VARCHAR2(240);
  /** Unreserved Keyword Word POINT **/
  POINT VARCHAR2(240);
  /** Unreserved Keyword Word POLICY **/
  POLICY VARCHAR2(240);
  /** Unreserved Keyword Word POST_TRANSACTION **/
  POST_TRANSACTION VARCHAR2(240);
  /** Unreserved Keyword Word POWER **/
  POWER VARCHAR2(240);
  /** Unreserved Keyword Word PQ_DISTRIBUTE **/
  PQ_DISTRIBUTE VARCHAR2(240);
  /** Unreserved Keyword Word PQ_MAP **/
  PQ_MAP VARCHAR2(240);
  /** Unreserved Keyword Word PQ_NOMAP **/
  PQ_NOMAP VARCHAR2(240);
  /** Unreserved Keyword Word PREBUILT **/
  PREBUILT VARCHAR2(240);
  /** Unreserved Keyword Word PRECEDING **/
  PRECEDING VARCHAR2(240);
  /** Unreserved Keyword Word PRECISION **/
  PRECISION VARCHAR2(240);
  /** Unreserved Keyword Word PRECOMPUTE_SUBQUERY **/
  PRECOMPUTE_SUBQUERY VARCHAR2(240);
  /** Unreserved Keyword Word PREPARE **/
  PREPARE VARCHAR2(240);
  /** Unreserved Keyword Word PRESENT **/
  PRESENT VARCHAR2(240);
  /** Unreserved Keyword Word PRESERVE **/
  PRESERVE VARCHAR2(240);
  /** Unreserved Keyword Word PRESERVE_OID **/
  PRESERVE_OID VARCHAR2(240);
  /** Unreserved Keyword Word PRIMARY **/
  PRIMARY VARCHAR2(240);
  /** Unreserved Keyword Word PRIVATE **/
  PRIVATE VARCHAR2(240);
  /** Unreserved Keyword Word PRIVATE_SGA **/
  PRIVATE_SGA VARCHAR2(240);
  /** Unreserved Keyword Word PRIVILEGE **/
  PRIVILEGE VARCHAR2(240);
  /** Unreserved Keyword Word PRIVILEGES **/
  PRIVILEGES VARCHAR2(240);
  /** Unreserved Keyword Word PROCEDURE **/
  "PROCEDURE" VARCHAR2(240);
  /** Unreserved Keyword Word PROFILE **/
  PROFILE VARCHAR2(240);
  /** Unreserved Keyword Word PROGRAM **/
  PROGRAM VARCHAR2(240);
  /** Unreserved Keyword Word PROJECT **/
  PROJECT VARCHAR2(240);
  /** Unreserved Keyword Word PROTECTED **/
  PROTECTED VARCHAR2(240);
  /** Unreserved Keyword Word PROTECTION **/
  PROTECTION VARCHAR2(240);
  /** Unreserved Keyword Word PULL_PRED **/
  PULL_PRED VARCHAR2(240);
  /** Unreserved Keyword Word PURGE **/
  PURGE VARCHAR2(240);
  /** Unreserved Keyword Word PUSH_PRED **/
  PUSH_PRED VARCHAR2(240);
  /** Unreserved Keyword Word PUSH_SUBQ **/
  PUSH_SUBQ VARCHAR2(240);
  /** Unreserved Keyword Word PX_GRANULE **/
  PX_GRANULE VARCHAR2(240);
  /** Unreserved Keyword Word PX_JOIN_FILTER **/
  PX_JOIN_FILTER VARCHAR2(240);
  /** Unreserved Keyword Word QB_NAME **/
  QB_NAME VARCHAR2(240);
  /** Unreserved Keyword Word QUERY **/
  QUERY VARCHAR2(240);
  /** Unreserved Keyword Word QUERY_BLOCK **/
  QUERY_BLOCK VARCHAR2(240);
  /** Unreserved Keyword Word QUEUE **/
  QUEUE VARCHAR2(240);
  /** Unreserved Keyword Word QUEUE_CURR **/
  QUEUE_CURR VARCHAR2(240);
  /** Unreserved Keyword Word QUEUE_ROWP **/
  QUEUE_ROWP VARCHAR2(240);
  /** Unreserved Keyword Word QUIESCE **/
  QUIESCE VARCHAR2(240);
  /** Unreserved Keyword Word QUOTA **/
  QUOTA VARCHAR2(240);
  /** Unreserved Keyword Word RANDOM **/
  RANDOM VARCHAR2(240);
  /** Unreserved Keyword Word RANGE **/
  RANGE VARCHAR2(240);
  /** Unreserved Keyword Word RAPIDLY **/
  RAPIDLY VARCHAR2(240);
  /** Unreserved Keyword Word RBA **/
  RBA VARCHAR2(240);
  /** Unreserved Keyword Word RBO_OUTLINE **/
  RBO_OUTLINE VARCHAR2(240);
  /** Unreserved Keyword Word READ **/
  READ VARCHAR2(240);
  /** Unreserved Keyword Word READS **/
  READS VARCHAR2(240);
  /** Unreserved Keyword Word REAL **/
  REAL VARCHAR2(240);
  /** Unreserved Keyword Word REBALANCE **/
  REBALANCE VARCHAR2(240);
  /** Unreserved Keyword Word REBUILD **/
  REBUILD VARCHAR2(240);
  /** Unreserved Keyword Word RECORDS_PER_BLOCK **/
  RECORDS_PER_BLOCK VARCHAR2(240);
  /** Unreserved Keyword Word RECOVER **/
  RECOVER VARCHAR2(240);
  /** Unreserved Keyword Word RECOVERABLE **/
  RECOVERABLE VARCHAR2(240);
  /** Unreserved Keyword Word RECOVERY **/
  RECOVERY VARCHAR2(240);
  /** Unreserved Keyword Word RECYCLE **/
  RECYCLE VARCHAR2(240);
  /** Unreserved Keyword Word RECYCLEBIN **/
  RECYCLEBIN VARCHAR2(240);
  /** Unreserved Keyword Word REDUCED **/
  REDUCED VARCHAR2(240);
  /** Unreserved Keyword Word REDUNDANCY **/
  REDUNDANCY VARCHAR2(240);
  /** Unreserved Keyword Word REF **/
  REF VARCHAR2(240);
  /** Unreserved Keyword Word REF_CASCADE_CURSOR **/
  REF_CASCADE_CURSOR VARCHAR2(240);
  /** Unreserved Keyword Word REFERENCE **/
  REFERENCE VARCHAR2(240);
  /** Unreserved Keyword Word REFERENCED **/
  REFERENCED VARCHAR2(240);
  /** Unreserved Keyword Word REFERENCES **/
  REFERENCES VARCHAR2(240);
  /** Unreserved Keyword Word REFERENCING **/
  "REFERENCING" VARCHAR2(240);
  /** Unreserved Keyword Word REFRESH **/
  REFRESH VARCHAR2(240);
  /** Unreserved Keyword Word REGEXP_LIKE **/
  REGEXP_LIKE VARCHAR2(240);
  /** Unreserved Keyword Word REGISTER **/
  REGISTER VARCHAR2(240);
  /** Unreserved Keyword Word REJECT **/
  REJECT VARCHAR2(240);
  /** Unreserved Keyword Word REKEY **/
  REKEY VARCHAR2(240);
  /** Unreserved Keyword Word RELATIONAL **/
  RELATIONAL VARCHAR2(240);
  /** Unreserved Keyword Word RELY **/
  RELY VARCHAR2(240);
  /** Unreserved Keyword Word REMOTE_MAPPED **/
  REMOTE_MAPPED VARCHAR2(240);
  /** Unreserved Keyword Word REPAIR **/
  REPAIR VARCHAR2(240);
  /** Unreserved Keyword Word REPLACE **/
  REPLACE VARCHAR2(240);
  /** Unreserved Keyword Word REQUIRED **/
  REQUIRED VARCHAR2(240);
  /** Unreserved Keyword Word RESET **/
  RESET VARCHAR2(240);
  /** Unreserved Keyword Word RESETLOGS **/
  RESETLOGS VARCHAR2(240);
  /** Unreserved Keyword Word RESIZE **/
  RESIZE VARCHAR2(240);
  /** Unreserved Keyword Word RESOLVE **/
  RESOLVE VARCHAR2(240);
  /** Unreserved Keyword Word RESOLVER **/
  RESOLVER VARCHAR2(240);
  /** Unreserved Keyword Word RESTORE **/
  RESTORE VARCHAR2(240);
  /** Unreserved Keyword Word RESTORE_AS_INTERVALS **/
  RESTORE_AS_INTERVALS VARCHAR2(240);
  /** Unreserved Keyword Word RESTRICT **/
  RESTRICT VARCHAR2(240);
  /** Unreserved Keyword Word RESTRICT_ALL_REF_CONS **/
  RESTRICT_ALL_REF_CONS VARCHAR2(240);
  /** Unreserved Keyword Word RESTRICTED **/
  RESTRICTED VARCHAR2(240);
  /** Unreserved Keyword Word RESUMABLE **/
  RESUMABLE VARCHAR2(240);
  /** Unreserved Keyword Word RESUME **/
  RESUME VARCHAR2(240);
  /** Unreserved Keyword Word RETENTION **/
  RETENTION VARCHAR2(240);
  /** Unreserved Keyword Word RESULT **/
  RESULT VARCHAR2(240);
  /** Unreserved Keyword Word RETURN **/
  RETURN VARCHAR2(240);
  /** Unreserved Keyword Word RETURNING **/
  RETURNING VARCHAR2(240);
  /** Unreserved Keyword Word REUSE **/
  REUSE VARCHAR2(240);
  /** Unreserved Keyword Word REVERSE **/
  REVERSE VARCHAR2(240);
  /** Unreserved Keyword Word REWRITE **/
  REWRITE VARCHAR2(240);
  /** Unreserved Keyword Word REWRITE_OR_ERROR **/
  REWRITE_OR_ERROR VARCHAR2(240);
  /** Unreserved Keyword Word RIGHT **/
  RIGHT VARCHAR2(240);
  /** Unreserved Keyword Word ROLE **/
  ROLE VARCHAR2(240);
  /** Unreserved Keyword Word ROLES **/
  ROLES VARCHAR2(240);
  /** Unreserved Keyword Word ROLLBACK **/
  ROLLBACK VARCHAR2(240);
  /** Unreserved Keyword Word ROLLING **/
  ROLLING VARCHAR2(240);
  /** Unreserved Keyword Word ROLLUP **/
  ROLLUP VARCHAR2(240);
  /** Unreserved Keyword Word ROW **/
  ROW VARCHAR2(240);
  /** Unreserved Keyword Word ROW_LENGTH **/
  ROW_LENGTH VARCHAR2(240);
  /** Unreserved Keyword Word ROWDEPENDENCIES **/
  ROWDEPENDENCIES VARCHAR2(240);
  /** Unreserved Keyword Word ROWID **/
  ROWID VARCHAR2(240);
  /** Unreserved Keyword Word ROWNUM **/
  ROWNUM VARCHAR2(240);
  /** Unreserved Keyword Word ROWS **/
  ROWS VARCHAR2(240);
  /** Unreserved Keyword Word RULE **/
  RULE VARCHAR2(240);
  /** Unreserved Keyword Word RULES **/
  RULES VARCHAR2(240);
  /** Unreserved Keyword Word SALT **/
  SALT VARCHAR2(240);
  /** Unreserved Keyword Word SAMPLE **/
  SAMPLE VARCHAR2(240);
  /** Unreserved Keyword Word SAVE_AS_INTERVALS **/
  SAVE_AS_INTERVALS VARCHAR2(240);
  /** Unreserved Keyword Word SAVEPOINT **/
  SAVEPOINT VARCHAR2(240);
  /** Unreserved Keyword Word SB4 **/
  SB4 VARCHAR2(240);
  /** Unreserved Keyword Word SCALE **/
  SCALE VARCHAR2(240);
  /** Unreserved Keyword Word SCALE_ROWS **/
  SCALE_ROWS VARCHAR2(240);
  /** Unreserved Keyword Word SCAN **/
  SCAN VARCHAR2(240);
  /** Unreserved Keyword Word SCAN_INSTANCES **/
  SCAN_INSTANCES VARCHAR2(240);
  /** Unreserved Keyword Word SCHEDULER **/
  SCHEDULER VARCHAR2(240);
  /** Unreserved Keyword Word SCHEMA **/
  SCHEMA VARCHAR2(240);
  /** Unreserved Keyword Word SCN **/
  SCN VARCHAR2(240);
  /** Unreserved Keyword Word SCN_ASCENDING **/
  SCN_ASCENDING VARCHAR2(240);
  /** Unreserved Keyword Word SCOPE **/
  SCOPE VARCHAR2(240);
  /** Unreserved Keyword Word SD_ALL **/
  SD_ALL VARCHAR2(240);
  /** Unreserved Keyword Word SD_INHIBIT **/
  SD_INHIBIT VARCHAR2(240);
  /** Unreserved Keyword Word SD_SHOW **/
  SD_SHOW VARCHAR2(240);
  /** Unreserved Keyword Word SECOND **/
  SECOND VARCHAR2(240);
  /** Unreserved Keyword Word SECURITY **/
  SECURITY VARCHAR2(240);
  /** Unreserved Keyword Word SEED **/
  SEED VARCHAR2(240);
  /** Unreserved Keyword Word SEG_BLOCK **/
  SEG_BLOCK VARCHAR2(240);
  /** Unreserved Keyword Word SEG_FILE **/
  SEG_FILE VARCHAR2(240);
  /** Unreserved Keyword Word SEGMENT **/
  SEGMENT VARCHAR2(240);
  /** Unreserved Keyword Word SELECTIVITY **/
  SELECTIVITY VARCHAR2(240);
  /** Unreserved Keyword Word SEMIJOIN **/
  SEMIJOIN VARCHAR2(240);
  /** Unreserved Keyword Word SEMIJOIN_DRIVER **/
  SEMIJOIN_DRIVER VARCHAR2(240);
  /** Unreserved Keyword Word SEQUENCE **/
  SEQUENCE VARCHAR2(240);
  /** Unreserved Keyword Word SEQUENCED **/
  SEQUENCED VARCHAR2(240);
  /** Unreserved Keyword Word SEQUENTIAL **/
  SEQUENTIAL VARCHAR2(240);
  /** Unreserved Keyword Word SERIALIZABLE **/
  SERIALIZABLE VARCHAR2(240);
  /** Unreserved Keyword Word SERVERERROR **/
  SERVERERROR VARCHAR2(240);
  /** Unreserved Keyword Word SESSION **/
  SESSION VARCHAR2(240);
  /** Unreserved Keyword Word SESSION_CACHED_CURSORS **/
  SESSION_CACHED_CURSORS VARCHAR2(240);
  /** Unreserved Keyword Word SESSIONS_PER_USER **/
  SESSIONS_PER_USER VARCHAR2(240);
  /** Unreserved Keyword Word SESSIONTIMEZONE **/
  SESSIONTIMEZONE VARCHAR2(240);
  /** Unreserved Keyword Word SESSIONTZNAME **/
  SESSIONTZNAME VARCHAR2(240);
  /** Unreserved Keyword Word SET_TO_JOIN **/
  SET_TO_JOIN VARCHAR2(240);
  /** Unreserved Keyword Word SETS **/
  SETS VARCHAR2(240);
  /** Unreserved Keyword Word SETTINGS **/
  SETTINGS VARCHAR2(240);
  /** Unreserved Keyword Word SEVERE **/
  SEVERE VARCHAR2(240);
  /** Unreserved Keyword Word SHARED **/
  SHARED VARCHAR2(240);
  /** Unreserved Keyword Word SHARED_POOL **/
  SHARED_POOL VARCHAR2(240);
  /** Unreserved Keyword Word SHRINK **/
  SHRINK VARCHAR2(240);
  /** Unreserved Keyword Word SHUTDOWN **/
  SHUTDOWN VARCHAR2(240);
  /** Unreserved Keyword Word SIBLINGS **/
  SIBLINGS VARCHAR2(240);
  /** Unreserved Keyword Word SID **/
  SID VARCHAR2(240);
  /** Unreserved Keyword Word SIMPLE **/
  SIMPLE VARCHAR2(240);
  /** Unreserved Keyword Word SINGLE **/
  SINGLE VARCHAR2(240);
  /** Unreserved Keyword Word SINGLETASK **/
  SINGLETASK VARCHAR2(240);
  /** Unreserved Keyword Word SKIP **/
  SKIP VARCHAR2(240);
  /** Unreserved Keyword Word SKIP_EXT_OPTIMIZER **/
  SKIP_EXT_OPTIMIZER VARCHAR2(240);
  /** Unreserved Keyword Word SKIP_UNQ_UNUSABLE_IDX **/
  SKIP_UNQ_UNUSABLE_IDX VARCHAR2(240);
  /** Unreserved Keyword Word SKIP_UNUSABLE_INDEXES **/
  SKIP_UNUSABLE_INDEXES VARCHAR2(240);
  /** Unreserved Keyword Word SMALLFILE **/
  SMALLFILE VARCHAR2(240);
  /** Unreserved Keyword Word SNAPSHOT **/
  SNAPSHOT VARCHAR2(240);
  /** Unreserved Keyword Word SOME **/
  SOME VARCHAR2(240);
  /** Unreserved Keyword Word SORT **/
  SORT VARCHAR2(240);
  /** Unreserved Keyword Word SOURCE **/
  SOURCE VARCHAR2(240);
  /** Unreserved Keyword Word SPACE **/
  SPACE VARCHAR2(240);
  /** Unreserved Keyword Word SPECIFICATION **/
  SPECIFICATION VARCHAR2(240);
  /** Unreserved Keyword Word SPFILE **/
  SPFILE VARCHAR2(240);
  /** Unreserved Keyword Word SPLIT **/
  SPLIT VARCHAR2(240);
  /** Unreserved Keyword Word SPREADSHEET **/
  SPREADSHEET VARCHAR2(240);
  /** Unreserved Keyword Word SQL **/
   "SQL" VARCHAR2(240);
  /** Unreserved Keyword Word SQL_TRACE **/
  SQL_TRACE VARCHAR2(240);
  /** Unreserved Keyword Word SQLLDR **/
  SQLLDR VARCHAR2(240);
  /** Unreserved Keyword Word STANDALONE **/
  STANDALONE VARCHAR2(240);
  /** Unreserved Keyword Word STANDBY **/
  STANDBY VARCHAR2(240);
  /** Unreserved Keyword Word STAR **/
  STAR VARCHAR2(240);
  /** Unreserved Keyword Word STAR_TRANSFORMATION **/
  STAR_TRANSFORMATION VARCHAR2(240);
  /** Unreserved Keyword Word STARTUP **/
  STARTUP VARCHAR2(240);
  /** Unreserved Keyword Word STATEMENT_ID **/
  STATEMENT_ID VARCHAR2(240);
  /** Unreserved Keyword Word STATIC **/
  STATIC VARCHAR2(240);
  /** Unreserved Keyword Word STATISTICS **/
  STATISTICS VARCHAR2(240);
  /** Unreserved Keyword Word STOP **/
  STOP VARCHAR2(240);
  /** Unreserved Keyword Word STORAGE **/
  STORAGE VARCHAR2(240);
  /** Unreserved Keyword Word STORE **/
  STORE VARCHAR2(240);
  /** Unreserved Keyword Word STREAMS **/
  STREAMS VARCHAR2(240);
  /** Unreserved Keyword Word STRICT **/
  STRICT VARCHAR2(240);
  /** Unreserved Keyword Word STRING **/
  STRING VARCHAR2(240);
  /** Unreserved Keyword Word STRIP **/
  STRIP VARCHAR2(240);
  /** Unreserved Keyword Word STRUCTURE **/
  STRUCTURE VARCHAR2(240);
  /** Unreserved Keyword Word SUBMULTISET **/
  SUBMULTISET VARCHAR2(240);
  /** Unreserved Keyword Word SUBPARTITION **/
  SUBPARTITION VARCHAR2(240);
  /** Unreserved Keyword Word SUBPARTITION_REL **/
  SUBPARTITION_REL VARCHAR2(240);
  /** Unreserved Keyword Word SUBPARTITIONS **/
  SUBPARTITIONS VARCHAR2(240);
  /** Unreserved Keyword Word SUBQUERIES **/
  SUBQUERIES VARCHAR2(240);
  /** Unreserved Keyword Word SUBSTITUTABLE **/
  SUBSTITUTABLE VARCHAR2(240);
  /** Unreserved Keyword Word SUCCESSFUL **/
  SUCCESSFUL VARCHAR2(240);
  /** Unreserved Keyword Word SUMMARY **/
  SUMMARY VARCHAR2(240);
  /** Unreserved Keyword Word SUPPLEMENTAL **/
  SUPPLEMENTAL VARCHAR2(240);
  /** Unreserved Keyword Word SUSPEND **/
  SUSPEND VARCHAR2(240);
  /** Unreserved Keyword Word SWAP_JOIN_INPUTS **/
  SWAP_JOIN_INPUTS VARCHAR2(240);
  /** Unreserved Keyword Word SWITCH **/
  SWITCH VARCHAR2(240);
  /** Unreserved Keyword Word SWITCHOVER **/
  SWITCHOVER VARCHAR2(240);
  /** Unreserved Keyword Word SYS_DL_CURSOR **/
  SYS_DL_CURSOR VARCHAR2(240);
  /** Unreserved Keyword Word SYS_FBT_INSDEL **/
  SYS_FBT_INSDEL VARCHAR2(240);
  /** Unreserved Keyword Word SYS_OP_BITVEC **/
  SYS_OP_BITVEC VARCHAR2(240);
  /** Unreserved Keyword Word SYS_OP_CAST **/
  SYS_OP_CAST VARCHAR2(240);
  /** Unreserved Keyword Word SYS_OP_ENFORCE_NOT_NULL$ **/
  SYS_OP_ENFORCE_NOT_NULL$ VARCHAR2(240);
  /** Unreserved Keyword Word SYS_OP_EXTRACT **/
  SYS_OP_EXTRACT VARCHAR2(240);
  /** Unreserved Keyword Word SYS_OP_NOEXPAND **/
  SYS_OP_NOEXPAND VARCHAR2(240);
  /** Unreserved Keyword Word SYS_OP_NTCIMG$ **/
  SYS_OP_NTCIMG$ VARCHAR2(240);
  /** Unreserved Keyword Word SYS_PARALLEL_TXN **/
  SYS_PARALLEL_TXN VARCHAR2(240);
  /** Unreserved Keyword Word SYS_RID_ORDER **/
  SYS_RID_ORDER VARCHAR2(240);
  /** Unreserved Keyword Word SYSAUX **/
  SYSAUX VARCHAR2(240);
  /** Unreserved Keyword Word SYSDATE **/
  SYSDATE VARCHAR2(240);
  /** Unreserved Keyword Word SYSDBA **/
  SYSDBA VARCHAR2(240);
  /** Unreserved Keyword Word SYSOPER **/
  SYSOPER VARCHAR2(240);
  /** Unreserved Keyword Word SYSTEM **/
  SYSTEM VARCHAR2(240);
  /** Unreserved Keyword Word SYSTIMESTAMP **/
  SYSTIMESTAMP VARCHAR2(240);
  /** Unreserved Keyword Word T **/
  T VARCHAR2(240);
  /** Unreserved Keyword Word TABLE_STATS **/
  TABLE_STATS VARCHAR2(240);
  /** Unreserved Keyword Word TABLES **/
  TABLES VARCHAR2(240);
  /** Unreserved Keyword Word TABLESPACE **/
  TABLESPACE VARCHAR2(240);
  /** Unreserved Keyword Word TABLESPACE_NO **/
  TABLESPACE_NO VARCHAR2(240);
  /** Unreserved Keyword Word TABNO **/
  TABNO VARCHAR2(240);
  /** Unreserved Keyword Word TEMP_TABLE **/
  TEMP_TABLE VARCHAR2(240);
  /** Unreserved Keyword Word TEMPFILE **/
  TEMPFILE VARCHAR2(240);
  /** Unreserved Keyword Word TEMPLATE **/
  TEMPLATE VARCHAR2(240);
  /** Unreserved Keyword Word TEMPORARY **/
  TEMPORARY VARCHAR2(240);
  /** Unreserved Keyword Word TEST **/
  TEST VARCHAR2(240);
  /** Unreserved Keyword Word THAN **/
  THAN VARCHAR2(240);
  /** Unreserved Keyword Word THE **/
  THE VARCHAR2(240);
  /** Unreserved Keyword Word THREAD **/
  THREAD VARCHAR2(240);
  /** Unreserved Keyword Word THROUGH **/
  THROUGH VARCHAR2(240);
  /** Unreserved Keyword Word TIME **/
  TIME VARCHAR2(240);
  /** Unreserved Keyword Word TIME_ZONE **/
  TIME_ZONE VARCHAR2(240);
  /** Unreserved Keyword Word TIMEOUT **/
  TIMEOUT VARCHAR2(240);
  /** Unreserved Keyword Word TIMESTAMP **/
  TIMESTAMP VARCHAR2(240);
  /** Unreserved Keyword Word TIMEZONE_ABBR **/
  TIMEZONE_ABBR VARCHAR2(240);
  /** Unreserved Keyword Word TIMEZONE_HOUR **/
  TIMEZONE_HOUR VARCHAR2(240);
  /** Unreserved Keyword Word TIMEZONE_MINUTE **/
  TIMEZONE_MINUTE VARCHAR2(240);
  /** Unreserved Keyword Word TIMEZONE_OFFSET **/
  TIMEZONE_OFFSET VARCHAR2(240);
  /** Unreserved Keyword Word TIMEZONE_REGION **/
  TIMEZONE_REGION VARCHAR2(240);
  /** Unreserved Keyword Word TIV_GB **/
  TIV_GB VARCHAR2(240);
  /** Unreserved Keyword Word TIV_SSF **/
  TIV_SSF VARCHAR2(240);
  /** Unreserved Keyword Word TO_CHAR **/
  TO_CHAR VARCHAR2(240);
  /** Unreserved Keyword Word TOPLEVEL **/
  TOPLEVEL VARCHAR2(240);
  /** Unreserved Keyword Word TRACE **/
  TRACE VARCHAR2(240);
  /** Unreserved Keyword Word TRACING **/
  TRACING VARCHAR2(240);
  /** Unreserved Keyword Word TRACKING **/
  TRACKING VARCHAR2(240);
  /** Unreserved Keyword Word TRAILING **/
  TRAILING VARCHAR2(240);
  /** Unreserved Keyword Word TRANSACTION **/
  TRANSACTION VARCHAR2(240);
  /** Unreserved Keyword Word TRANSITIONAL **/
  TRANSITIONAL VARCHAR2(240);
  /** Unreserved Keyword Word TREAT **/
  TREAT VARCHAR2(240);
  /** Unreserved Keyword Word TRIGGERS **/
  TRIGGERS VARCHAR2(240);
  /** Unreserved Keyword Word TRUNCATE **/
  TRUNCATE VARCHAR2(240);
  /** Unreserved Keyword Word TRUSTED **/
  TRUSTED VARCHAR2(240);
  /** Unreserved Keyword Word TUNING **/
  TUNING VARCHAR2(240);
  /** Unreserved Keyword Word TX **/
  TX VARCHAR2(240);
  /** Unreserved Keyword Word TYPE **/
   "TYPE" VARCHAR2(240);
  /** Unreserved Keyword Word TYPES **/
  TYPES VARCHAR2(240);
  /** Unreserved Keyword Word TZ_OFFSET **/
  TZ_OFFSET VARCHAR2(240);
  /** Unreserved Keyword Word U **/
  U VARCHAR2(240);
  /** Unreserved Keyword Word UB2 **/
  UB2 VARCHAR2(240);
  /** Unreserved Keyword Word UBA **/
  UBA VARCHAR2(240);
  /** Unreserved Keyword Word UID **/
  UID VARCHAR2(240);
  /** Unreserved Keyword Word UNARCHIVED **/
  UNARCHIVED VARCHAR2(240);
  /** Unreserved Keyword Word UNBOUND **/
  UNBOUND VARCHAR2(240);
  /** Unreserved Keyword Word UNBOUNDED **/
  UNBOUNDED VARCHAR2(240);
  /** Unreserved Keyword Word UNDER **/
  UNDER VARCHAR2(240);
  /** Unreserved Keyword Word UNDO **/
  UNDO VARCHAR2(240);
  /** Unreserved Keyword Word UNDROP **/
  UNDROP VARCHAR2(240);
  /** Unreserved Keyword Word UNIFORM **/
  UNIFORM VARCHAR2(240);
  /** Unreserved Keyword Word UNLIMITED **/
  UNLIMITED VARCHAR2(240);
  /** Unreserved Keyword Word UNLOCK **/
  UNLOCK VARCHAR2(240);
  /** Unreserved Keyword Word UNNEST **/
  UNNEST VARCHAR2(240);
  /** Unreserved Keyword Word UNPACKED **/
  UNPACKED VARCHAR2(240);
  /** Unreserved Keyword Word UNPROTECTED **/
  UNPROTECTED VARCHAR2(240);
  /** Unreserved Keyword Word UNQUIESCE **/
  UNQUIESCE VARCHAR2(240);
  /** Unreserved Keyword Word UNRECOVERABLE **/
  UNRECOVERABLE VARCHAR2(240);
  /** Unreserved Keyword Word UNTIL **/
  UNTIL VARCHAR2(240);
  /** Unreserved Keyword Word UNUSABLE **/
  UNUSABLE VARCHAR2(240);
  /** Unreserved Keyword Word UNUSED **/
  UNUSED VARCHAR2(240);
  /** Unreserved Keyword Word UPD_INDEXES **/
  UPD_INDEXES VARCHAR2(240);
  /** Unreserved Keyword Word UPD_JOININDEX **/
  UPD_JOININDEX VARCHAR2(240);
  /** Unreserved Keyword Word UPDATABLE **/
  UPDATABLE VARCHAR2(240);
  /** Unreserved Keyword Word UPDATED **/
  UPDATED VARCHAR2(240);
  /** Unreserved Keyword Word UPGRADE **/
  UPGRADE VARCHAR2(240);
  /** Unreserved Keyword Word UPSERT **/
  UPSERT VARCHAR2(240);
  /** Unreserved Keyword Word UROWID **/
  UROWID VARCHAR2(240);
  /** Unreserved Keyword Word USAGE **/
  USAGE VARCHAR2(240);
  /** Unreserved Keyword Word USE **/
  USE VARCHAR2(240);
  /** Unreserved Keyword Word USE_ANTI **/
  USE_ANTI VARCHAR2(240);
  /** Unreserved Keyword Word USE_CONCAT **/
  USE_CONCAT VARCHAR2(240);
  /** Unreserved Keyword Word USE_HASH **/
  USE_HASH VARCHAR2(240);
  /** Unreserved Keyword Word USE_HASH_AGGREGATION **/
  USE_HASH_AGGREGATION VARCHAR2(240);
  /** Unreserved Keyword Word USE_MERGE **/
  USE_MERGE VARCHAR2(240);
  /** Unreserved Keyword Word USE_NL **/
  USE_NL VARCHAR2(240);
  /** Unreserved Keyword Word USE_NL_WITH_INDEX **/
  USE_NL_WITH_INDEX VARCHAR2(240);
  /** Unreserved Keyword Word USE_PRIVATE_OUTLINES **/
  USE_PRIVATE_OUTLINES VARCHAR2(240);
  /** Unreserved Keyword Word USE_SEMI **/
  USE_SEMI VARCHAR2(240);
  /** Unreserved Keyword Word USE_STORED_OUTLINES **/
  USE_STORED_OUTLINES VARCHAR2(240);
  /** Unreserved Keyword Word USE_TTT_FOR_GSETS **/
  USE_TTT_FOR_GSETS VARCHAR2(240);
  /** Unreserved Keyword Word USE_WEAK_NAME_RESL **/
  USE_WEAK_NAME_RESL VARCHAR2(240);
  /** Unreserved Keyword Word USER **/
  USER VARCHAR2(240);
  /** Unreserved Keyword Word USER_DEFINED **/
  USER_DEFINED VARCHAR2(240);
  /** Unreserved Keyword Word USER_RECYCLEBIN **/
  USER_RECYCLEBIN VARCHAR2(240);
  /** Unreserved Keyword Word USERS **/
  USERS VARCHAR2(240);
  /** Unreserved Keyword Word USING **/
  USING VARCHAR2(240);
  /** Unreserved Keyword Word VALIDATE **/
  VALIDATE VARCHAR2(240);
  /** Unreserved Keyword Word VALIDATION **/
  VALIDATION VARCHAR2(240);
  /** Unreserved Keyword Word VALUE **/
  VALUE VARCHAR2(240);
  /** Unreserved Keyword Word VARRAY **/
  VARRAY VARCHAR2(240);
  /** Unreserved Keyword Word VARYING **/
  VARYING VARCHAR2(240);
  /** Unreserved Keyword Word VECTOR_READ **/
  VECTOR_READ VARCHAR2(240);
  /** Unreserved Keyword Word VECTOR_READ_TRACE **/
  VECTOR_READ_TRACE VARCHAR2(240);
  /** Unreserved Keyword Word VERSION **/
  VERSION VARCHAR2(240);
  /** Unreserved Keyword Word VERSIONS **/
  VERSIONS VARCHAR2(240);
  /** Unreserved Keyword Word WAIT **/
  WAIT VARCHAR2(240);
  /** Unreserved Keyword Word WALLET **/
  WALLET VARCHAR2(240);
  /** Unreserved Keyword Word WELLFORMED **/
  WELLFORMED VARCHAR2(240);
  /** Unreserved Keyword Word WHEN **/
  "WHEN" VARCHAR2(240);
  /** Unreserved Keyword Word WHENEVER **/
  WHENEVER VARCHAR2(240);
  /** Unreserved Keyword Word WHITESPACE **/
  WHITESPACE VARCHAR2(240);
  /** Unreserved Keyword Word WITHIN **/
  WITHIN VARCHAR2(240);
  /** Unreserved Keyword Word WITHOUT **/
  WITHOUT VARCHAR2(240);
  /** Unreserved Keyword Word WORK **/
  WORK VARCHAR2(240);
  /** Unreserved Keyword Word WRAPPED **/
  WRAPPED VARCHAR2(240);
  /** Unreserved Keyword Word WRITE **/
  WRITE VARCHAR2(240);
  /** Unreserved Keyword Word X_DYN_PRUNE **/
  X_DYN_PRUNE VARCHAR2(240);
  /** Unreserved Keyword Word XID **/
  XID VARCHAR2(240);
  /** Unreserved Keyword Word XML_DML_RWT_STMT **/
  XML_DML_RWT_STMT VARCHAR2(240);
  /** Unreserved Keyword Word XMLATTRIBUTES **/
  XMLATTRIBUTES VARCHAR2(240);
  /** Unreserved Keyword Word XMLCOLATTVAL **/
  XMLCOLATTVAL VARCHAR2(240);
  /** Unreserved Keyword Word XMLELEMENT **/
  XMLELEMENT VARCHAR2(240);
  /** Unreserved Keyword Word XMLFOREST **/
  XMLFOREST VARCHAR2(240);
  /** Unreserved Keyword Word XMLNAMESPACES **/
  XMLNAMESPACES VARCHAR2(240);
  /** Unreserved Keyword Word XMLPARSE **/
  XMLPARSE VARCHAR2(240);
  /** Unreserved Keyword Word XMLPI **/
  XMLPI VARCHAR2(240);
  /** Unreserved Keyword Word XMLQUERY **/
  XMLQUERY VARCHAR2(240);
  /** Unreserved Keyword Word XMLROOT **/
  XMLROOT VARCHAR2(240);
  /** Unreserved Keyword Word XMLSCHEMA **/
  XMLSCHEMA VARCHAR2(240);
  /** Unreserved Keyword Word XMLSERIALIZE **/
  XMLSERIALIZE VARCHAR2(240);
  /** Unreserved Keyword Word XMLTABLE **/
  XMLTABLE VARCHAR2(240);
  /** Unreserved Keyword Word XMLTYPE **/
  XMLTYPE VARCHAR2(240);
  /** Unreserved Keyword Word YEAR **/
  YEAR VARCHAR2(240);
  /** Unreserved Keyword Word YES **/
  YES VARCHAR2(240);
  /** Unreserved Keyword Word ZONE **/
  ZONE VARCHAR2(240);
BEGIN
  FALSE := 'FALSE' ; -- FALSE VARCHAR2(240)
  TRUE := 'TRUE' ; -- TRUE VARCHAR2(240)
  A := 'A' ; -- A VARCHAR2(240)
  ABORT := 'ABORT' ; -- ABORT VARCHAR2(240)
  ACCESS := 'ACCESS' ; -- ACCESS VARCHAR2(240)
  ACCESSED := 'ACCESSED' ; -- ACCESSED VARCHAR2(240)
  ACCOUNT := 'ACCOUNT' ; -- ACCOUNT VARCHAR2(240)
  ACTIVATE := 'ACTIVATE' ; -- ACTIVATE VARCHAR2(240)
  ADD := 'ADD' ; -- ADD VARCHAR2(240)
  ADMIN := 'ADMIN' ; -- ADMIN VARCHAR2(240)
  ADMINISTER := 'ADMINISTER' ; -- ADMINISTER VARCHAR2(240)
  ADMINISTRATOR := 'ADMINISTRATOR' ; -- ADMINISTRATOR VARCHAR2(240)
  ADVISE := 'ADVISE' ; -- ADVISE VARCHAR2(240)
  ADVISOR := 'ADVISOR' ; -- ADVISOR VARCHAR2(240)
  AFTER := 'AFTER' ; -- AFTER VARCHAR2(240)
  AGGREGATE := 'AGGREGATE' ; -- AGGREGATE VARCHAR2(240)
  ALIAS := 'ALIAS' ; -- ALIAS VARCHAR2(240)
  ALL_ROWS := 'ALL_ROWS' ; -- ALL_ROWS VARCHAR2(240)
  ALLOCATE := 'ALLOCATE' ; -- ALLOCATE VARCHAR2(240)
  ALLOW := 'ALLOW' ; -- ALLOW VARCHAR2(240)
  ALWAYS := 'ALWAYS' ; -- ALWAYS VARCHAR2(240)
  ANALYZE := 'ANALYZE' ; -- ANALYZE VARCHAR2(240)
  ANCILLARY := 'ANCILLARY' ; -- ANCILLARY VARCHAR2(240)
  AND_EQUAL := 'AND_EQUAL' ; -- AND_EQUAL VARCHAR2(240)
  ANTIJOIN := 'ANTIJOIN' ; -- ANTIJOIN VARCHAR2(240)
  APPEND := 'APPEND' ; -- APPEND VARCHAR2(240)
  APPLY := 'APPLY' ; -- APPLY VARCHAR2(240)
  ARCHIVE := 'ARCHIVE' ; -- ARCHIVE VARCHAR2(240)
  ARCHIVELOG := 'ARCHIVELOG' ; -- ARCHIVELOG VARCHAR2(240)
  ARRAY := 'ARRAY' ; -- ARRAY VARCHAR2(240)
  ASSOCIATE := 'ASSOCIATE' ; -- ASSOCIATE VARCHAR2(240)
  --SRT 20120430  AT := 'AT' ; -- AT VARCHAR2(240)
  ATTRIBUTE := 'ATTRIBUTE' ; -- ATTRIBUTE VARCHAR2(240)
  ATTRIBUTES := 'ATTRIBUTES' ; -- ATTRIBUTES VARCHAR2(240)
  AUDIT := 'AUDIT' ; -- AUDIT VARCHAR2(240)
  AUTHENTICATED := 'AUTHENTICATED' ; -- AUTHENTICATED VARCHAR2(240)
  AUTHENTICATION := 'AUTHENTICATION' ; -- AUTHENTICATION VARCHAR2(240)
  AUTHID := 'AUTHID' ; -- AUTHID VARCHAR2(240)
  AUTHORIZATION := 'AUTHORIZATION' ; -- AUTHORIZATION VARCHAR2(240)
  AUTO := 'AUTO' ; -- AUTO VARCHAR2(240)
  AUTOALLOCATE := 'AUTOALLOCATE' ; -- AUTOALLOCATE VARCHAR2(240)
  AUTOEXTEND := 'AUTOEXTEND' ; -- AUTOEXTEND VARCHAR2(240)
  AUTOMATIC := 'AUTOMATIC' ; -- AUTOMATIC VARCHAR2(240)
  AVAILABILITY := 'AVAILABILITY' ; -- AVAILABILITY VARCHAR2(240)
  BACKUP := 'BACKUP' ; -- BACKUP VARCHAR2(240)
  BATCH := 'BATCH' ; -- BATCH VARCHAR2(240)
  BECOME := 'BECOME' ; -- BECOME VARCHAR2(240)
  BEFORE := 'BEFORE' ; -- BEFORE VARCHAR2(240)
  --SRT BEGIN := 'BEGIN' ; BEGIN VARCHAR2(240)
  BEGIN_OUTLINE_DATA := 'BEGIN_OUTLINE_DATA' ; -- BEGIN_OUTLINE_DATA VARCHAR2(240)
  BEHALF := 'BEHALF' ; -- BEHALF VARCHAR2(240)
  BFILE := 'BFILE' ; -- BFILE VARCHAR2(240)
  BIGFILE := 'BIGFILE' ; -- BIGFILE VARCHAR2(240)
  BINARY_DOUBLE := 'BINARY_DOUBLE' ; -- BINARY_DOUBLE VARCHAR2(240)
  BINARY_DOUBLE_INFINITY := 'BINARY_DOUBLE_INFINITY' ; -- BINARY_DOUBLE_INFINITY VARCHAR2(240)
  BINARY_DOUBLE_NAN := 'BINARY_DOUBLE_NAN' ; -- BINARY_DOUBLE_NAN VARCHAR2(240)
  BINARY_FLOAT := 'BINARY_FLOAT' ; -- BINARY_FLOAT VARCHAR2(240)
  BINARY_FLOAT_INFINITY := 'BINARY_FLOAT_INFINITY' ; -- BINARY_FLOAT_INFINITY VARCHAR2(240)
  BINARY_FLOAT_NAN := 'BINARY_FLOAT_NAN' ; -- BINARY_FLOAT_NAN VARCHAR2(240)
  BINDING := 'BINDING' ; -- BINDING VARCHAR2(240)
  BITMAP := 'BITMAP' ; -- BITMAP VARCHAR2(240)
  BITMAP_TREE := 'BITMAP_TREE' ; -- BITMAP_TREE VARCHAR2(240)
  BITMAPS := 'BITMAPS' ; -- BITMAPS VARCHAR2(240)
  BITS := 'BITS' ; -- BITS VARCHAR2(240)
  BLOB := 'BLOB' ; -- BLOB VARCHAR2(240)
  BLOCK := 'BLOCK' ; -- BLOCK VARCHAR2(240)
  BLOCK_RANGE := 'BLOCK_RANGE' ; -- BLOCK_RANGE VARCHAR2(240)
  BLOCKS := 'BLOCKS' ; -- BLOCKS VARCHAR2(240)
  BLOCKSIZE := 'BLOCKSIZE' ; -- BLOCKSIZE VARCHAR2(240)
  BODY := 'BODY' ; -- BODY VARCHAR2(240)
  BOTH := 'BOTH' ; -- BOTH VARCHAR2(240)
  BOUND := 'BOUND' ; -- BOUND VARCHAR2(240)
  BROADCAST := 'BROADCAST' ; -- BROADCAST VARCHAR2(240)
  BUFFER := 'BUFFER' ; -- BUFFER VARCHAR2(240)
  BUFFER_CACHE := 'BUFFER_CACHE' ; -- BUFFER_CACHE VARCHAR2(240)
  BUFFER_POOL := 'BUFFER_POOL' ; -- BUFFER_POOL VARCHAR2(240)
  BUILD := 'BUILD' ; -- BUILD VARCHAR2(240)
  BULK := 'BULK' ; -- BULK VARCHAR2(240)
  --SRT 20120430  BY := 'BY' ; -- BY VARCHAR2(240)
  BYPASS_RECURSIVE_CHECK := 'BYPASS_RECURSIVE_CHECK' ; -- BYPASS_RECURSIVE_CHECK VARCHAR2(240)
  BYPASS_UJVC := 'BYPASS_UJVC' ; -- BYPASS_UJVC VARCHAR2(240)
  BYTE := 'BYTE' ; -- BYTE VARCHAR2(240)
  CACHE := 'CACHE' ; -- CACHE VARCHAR2(240)
  CACHE_CB := 'CACHE_CB' ; -- CACHE_CB VARCHAR2(240)
  CACHE_INSTANCES := 'CACHE_INSTANCES' ; -- CACHE_INSTANCES VARCHAR2(240)
  CACHE_TEMP_TABLE := 'CACHE_TEMP_TABLE' ; -- CACHE_TEMP_TABLE VARCHAR2(240)
  CALL := 'CALL' ; -- CALL VARCHAR2(240)
  CANCEL := 'CANCEL' ; -- CANCEL VARCHAR2(240)
  CARDINALITY := 'CARDINALITY' ; -- CARDINALITY VARCHAR2(240)
  CASCADE := 'CASCADE' ; -- CASCADE VARCHAR2(240)
  --SRT 20110508 CASE := 'CASE' ; -- CASE VARCHAR2(240)
  CAST := 'CAST' ; -- CAST VARCHAR2(240)
  CATEGORY := 'CATEGORY' ; -- CATEGORY VARCHAR2(240)
  CERTIFICATE := 'CERTIFICATE' ; -- CERTIFICATE VARCHAR2(240)
  CFILE := 'CFILE' ; -- CFILE VARCHAR2(240)
  CHAINED := 'CHAINED' ; -- CHAINED VARCHAR2(240)
  CHANGE := 'CHANGE' ; -- CHANGE VARCHAR2(240)
  CHAR_CS := 'CHAR_CS' ; -- CHAR_CS VARCHAR2(240)
  CHARACTER := 'CHARACTER' ; -- CHARACTER VARCHAR2(240)
  CHECKPOINT := 'CHECKPOINT' ; -- CHECKPOINT VARCHAR2(240)
  CHILD := 'CHILD' ; -- CHILD VARCHAR2(240)
  CHOOSE := 'CHOOSE' ; -- CHOOSE VARCHAR2(240)
  CHUNK := 'CHUNK' ; -- CHUNK VARCHAR2(240)
  CIV_GB := 'CIV_GB' ; -- CIV_GB VARCHAR2(240)
  CLASS := 'CLASS' ; -- CLASS VARCHAR2(240)
  CLEAR := 'CLEAR' ; -- CLEAR VARCHAR2(240)
  CLOB := 'CLOB' ; -- CLOB VARCHAR2(240)
  CLONE := 'CLONE' ; -- CLONE VARCHAR2(240)
  --SRT 20110508 CLOSE := 'CLOSE' ; -- CLOSE VARCHAR2(240)
  CLOSE_CACHED_OPEN_CURSORS := 'CLOSE_CACHED_OPEN_CURSORS' ; -- CLOSE_CACHED_OPEN_CURSORS VARCHAR2(240)
  CLUSTERING_FACTOR := 'CLUSTERING_FACTOR' ; -- CLUSTERING_FACTOR VARCHAR2(240)
  COALESCE := 'COALESCE' ; -- COALESCE VARCHAR2(240)
  COARSE := 'COARSE' ; -- COARSE VARCHAR2(240)
  --SRT 20110508 COLLECT := 'COLLECT' ; -- COLLECT VARCHAR2(240)
  COLUMN := 'COLUMN' ; -- COLUMN VARCHAR2(240)
  COLUMN_STATS := 'COLUMN_STATS' ; -- COLUMN_STATS VARCHAR2(240)
  COLUMN_VALUE := 'COLUMN_VALUE' ; -- COLUMN_VALUE VARCHAR2(240)
  --SRT 20120430  COLUMNS := 'COLUMNS' ; -- COLUMNS VARCHAR2(240)
  COMMENT := 'COMMENT' ; -- COMMENT VARCHAR2(240)
  --SRT 20120430  COMMIT := 'COMMIT' ; -- COMMIT VARCHAR2(240)
  COMMITTED := 'COMMITTED' ; -- COMMITTED VARCHAR2(240)
  COMPACT := 'COMPACT' ; -- COMPACT VARCHAR2(240)
  COMPATIBILITY := 'COMPATIBILITY' ; -- COMPATIBILITY VARCHAR2(240)
  COMPILE := 'COMPILE' ; -- COMPILE VARCHAR2(240)
  COMPLETE := 'COMPLETE' ; -- COMPLETE VARCHAR2(240)
  COMPOSITE_LIMIT := 'COMPOSITE_LIMIT' ; -- COMPOSITE_LIMIT VARCHAR2(240)
  COMPUTE := 'COMPUTE' ; -- COMPUTE VARCHAR2(240)
  CONFORMING := 'CONFORMING' ; -- CONFORMING VARCHAR2(240)
  CONNECT_BY_COST_BASED := 'CONNECT_BY_COST_BASED' ; -- CONNECT_BY_COST_BASED VARCHAR2(240)
  CONNECT_BY_FILTERING := 'CONNECT_BY_FILTERING' ; -- CONNECT_BY_FILTERING VARCHAR2(240)
  CONNECT_BY_ISCYCLE := 'CONNECT_BY_ISCYCLE' ; -- CONNECT_BY_ISCYCLE VARCHAR2(240)
  CONNECT_BY_ISLEAF := 'CONNECT_BY_ISLEAF' ; -- CONNECT_BY_ISLEAF VARCHAR2(240)
  CONNECT_BY_ROOT := 'CONNECT_BY_ROOT' ; -- CONNECT_BY_ROOT VARCHAR2(240)
  CONNECT_TIME := 'CONNECT_TIME' ; -- CONNECT_TIME VARCHAR2(240)
  CONSIDER := 'CONSIDER' ; -- CONSIDER VARCHAR2(240)
  CONSISTENT := 'CONSISTENT' ; -- CONSISTENT VARCHAR2(240)
  CONSTRAINT := 'CONSTRAINT' ; -- CONSTRAINT VARCHAR2(240)
  CONSTRAINTS := 'CONSTRAINTS' ; -- CONSTRAINTS VARCHAR2(240)
  CONSTRUCTOR := 'CONSTRUCTOR' ; -- CONSTRAINTS VARCHAR2(240)
  CONTAINER := 'CONTAINER' ; -- CONTAINER VARCHAR2(240)
  CONTENT := 'CONTENT' ; -- CONTENT VARCHAR2(240)
  CONTENTS := 'CONTENTS' ; -- CONTENTS VARCHAR2(240)
  CONTEXT := 'CONTEXT' ; -- CONTEXT VARCHAR2(240)
  CONTINUE := 'CONTINUE' ; -- CONTINUE VARCHAR2(240)
  CONTROLFILE := 'CONTROLFILE' ; -- CONTROLFILE VARCHAR2(240)
  CONVERT := 'CONVERT' ; -- CONVERT VARCHAR2(240)
  CORRUPTION := 'CORRUPTION' ; -- CORRUPTION VARCHAR2(240)
  COST := 'COST' ; -- COST VARCHAR2(240)
  CPU_COSTING := 'CPU_COSTING' ; -- CPU_COSTING VARCHAR2(240)
  CPU_PER_CALL := 'CPU_PER_CALL' ; -- CPU_PER_CALL VARCHAR2(240)
  CPU_PER_SESSION := 'CPU_PER_SESSION' ; -- CPU_PER_SESSION VARCHAR2(240)
  CREATE_STORED_OUTLINES := 'CREATE_STORED_OUTLINES' ; -- CREATE_STORED_OUTLINES VARCHAR2(240)
  CROSS := 'CROSS' ; -- CROSS VARCHAR2(240)
  CUBE := 'CUBE' ; -- CUBE VARCHAR2(240)
  CUBE_GB := 'CUBE_GB' ; -- CUBE_GB VARCHAR2(240)
  --SRT 20110508 CURRENT := 'CURRENT' ; -- CURRENT VARCHAR2(240)
  CURRENT_DATE := 'CURRENT_DATE' ; -- CURRENT_DATE VARCHAR2(240)
  CURRENT_SCHEMA := 'CURRENT_SCHEMA' ; -- CURRENT_SCHEMA VARCHAR2(240)
  CURRENT_TIME := 'CURRENT_TIME' ; -- CURRENT_TIME VARCHAR2(240)
  CURRENT_TIMESTAMP := 'CURRENT_TIMESTAMP' ; -- CURRENT_TIMESTAMP VARCHAR2(240)
  CURRENT_USER := 'CURRENT_USER' ; -- CURRENT_USER VARCHAR2(240)
  CURSOR := 'CURSOR' ; -- CURSOR VARCHAR2(240)
  CURSOR_SHARING_EXACT := 'CURSOR_SHARING_EXACT' ; -- CURSOR_SHARING_EXACT VARCHAR2(240)
  CURSOR_SPECIFIC_SEGMENT := 'CURSOR_SPECIFIC_SEGMENT' ; -- CURSOR_SPECIFIC_SEGMENT VARCHAR2(240)
  CYCLE := 'CYCLE' ; -- CYCLE VARCHAR2(240)
  DANGLING := 'DANGLING' ; -- DANGLING VARCHAR2(240)
  DATA := 'DATA' ; -- DATA VARCHAR2(240)
  DATABASE := 'DATABASE' ; -- DATABASE VARCHAR2(240)
  DATAFILE := 'DATAFILE' ; -- DATAFILE VARCHAR2(240)
  DATAFILES := 'DATAFILES' ; -- DATAFILES VARCHAR2(240)
  DATAOBJNO := 'DATAOBJNO' ; -- DATAOBJNO VARCHAR2(240)
  DATE_MODE := 'DATE_MODE' ; -- DATE_MODE VARCHAR2(240)
  DAY := 'DAY' ; -- DAY VARCHAR2(240)
  DB_ROLE_CHANGE := 'DB_ROLE_CHANGE' ; -- DB_ROLE_CHANGE VARCHAR2(240)
  DBA := 'DBA' ; -- DBA VARCHAR2(240)
  DBA_RECYCLEBIN := 'DBA_RECYCLEBIN' ; -- DBA_RECYCLEBIN VARCHAR2(240)
  DBMS_STATS := 'DBMS_STATS' ; -- DBMS_STATS VARCHAR2(240)
  DBTIMEZONE := 'DBTIMEZONE' ; -- DBTIMEZONE VARCHAR2(240)
  DDL := 'DDL' ; -- DDL VARCHAR2(240)
  DEALLOCATE := 'DEALLOCATE' ; -- DEALLOCATE VARCHAR2(240)
  DEBUG := 'DEBUG' ; -- DEBUG VARCHAR2(240)
  --SRT 20110508 DEC := 'DEC' ; -- DEC VARCHAR2(240)
  --SRT 20110508 DECLARE := 'DECLARE' ; -- DECLARE VARCHAR2(240)
  DECREMENT := 'DECREMENT' ; -- DECREMENT VARCHAR2(240)
  DECRYPT := 'DECRYPT' ; -- DECRYPT VARCHAR2(240)
  DEFERRABLE := 'DEFERRABLE' ; -- DEFERRABLE VARCHAR2(240)
  DEFERRED := 'DEFERRED' ; -- DEFERRED VARCHAR2(240)
  DEFINED := 'DEFINED' ; -- DEFINED VARCHAR2(240)
  --SRT 20110508 DEFINER := 'DEFINER' ; -- DEFINER VARCHAR2(240)
  DEGREE := 'DEGREE' ; -- DEGREE VARCHAR2(240)
  DELAY := 'DELAY' ; -- DELAY VARCHAR2(240)
  DEMAND := 'DEMAND' ; -- DEMAND VARCHAR2(240)
  DENSE_RANK := 'DENSE_RANK' ; -- DENSE_RANK VARCHAR2(240)
  DEQUEUE := 'DEQUEUE' ; -- DEQUEUE VARCHAR2(240)
  DEREF := 'DEREF' ; -- DEREF VARCHAR2(240)
  DEREF_NO_REWRITE := 'DEREF_NO_REWRITE' ; -- DEREF_NO_REWRITE VARCHAR2(240)
  DETACHED := 'DETACHED' ; -- DETACHED VARCHAR2(240)
  DETERMINES := 'DETERMINES' ; -- DETERMINES VARCHAR2(240)
  DICTIONARY := 'DICTIONARY' ; -- DICTIONARY VARCHAR2(240)
  DIMENSION := 'DIMENSION' ; -- DIMENSION VARCHAR2(240)
  DIRECTORY := 'DIRECTORY' ; -- DIRECTORY VARCHAR2(240)
  DISABLE := 'DISABLE' ; -- DISABLE VARCHAR2(240)
  DISABLE_RPKE := 'DISABLE_RPKE' ; -- DISABLE_RPKE VARCHAR2(240)
  DISASSOCIATE := 'DISASSOCIATE' ; -- DISASSOCIATE VARCHAR2(240)
  DISCONNECT := 'DISCONNECT' ; -- DISCONNECT VARCHAR2(240)
  DISK := 'DISK' ; -- DISK VARCHAR2(240)
  DISKGROUP := 'DISKGROUP' ; -- DISKGROUP VARCHAR2(240)
  DISKS := 'DISKS' ; -- DISKS VARCHAR2(240)
  DISMOUNT := 'DISMOUNT' ; -- DISMOUNT VARCHAR2(240)
  DISTINGUISHED := 'DISTINGUISHED' ; -- DISTINGUISHED VARCHAR2(240)
  DISTRIBUTED := 'DISTRIBUTED' ; -- DISTRIBUTED VARCHAR2(240)
  DML := 'DML' ; -- DML VARCHAR2(240)
  DML_UPDATE := 'DML_UPDATE' ; -- DML_UPDATE VARCHAR2(240)
  DOCUMENT := 'DOCUMENT' ; -- DOCUMENT VARCHAR2(240)
  DOMAIN_INDEX_NO_SORT := 'DOMAIN_INDEX_NO_SORT' ; -- DOMAIN_INDEX_NO_SORT VARCHAR2(240)
  DOMAIN_INDEX_SORT := 'DOMAIN_INDEX_SORT' ; -- DOMAIN_INDEX_SORT VARCHAR2(240)
  --SRT 20110508 DOUBLE := 'DOUBLE' ; -- DOUBLE VARCHAR2(240)
  DOWNGRADE := 'DOWNGRADE' ; -- DOWNGRADE VARCHAR2(240)
  DRIVING_SITE := 'DRIVING_SITE' ; -- DRIVING_SITE VARCHAR2(240)
  DUMP := 'DUMP' ; -- DUMP VARCHAR2(240)
  DYNAMIC := 'DYNAMIC' ; -- DYNAMIC VARCHAR2(240)
  DYNAMIC_SAMPLING := 'DYNAMIC_SAMPLING' ; -- DYNAMIC_SAMPLING VARCHAR2(240)
  DYNAMIC_SAMPLING_EST_CDN := 'DYNAMIC_SAMPLING_EST_CDN' ; -- DYNAMIC_SAMPLING_EST_CDN VARCHAR2(240)
  E := 'E' ; -- E VARCHAR2(240)
  EACH := 'EACH' ; -- EACH VARCHAR2(240)
  ELEMENT := 'ELEMENT' ; -- ELEMENT VARCHAR2(240)
  ELIMINATE_JOIN := 'ELIMINATE_JOIN' ; -- ELIMINATE_JOIN VARCHAR2(240)
  ELIMINATE_OBY := 'ELIMINATE_OBY' ; -- ELIMINATE_OBY VARCHAR2(240)
  ELIMINATE_OUTER_JOIN := 'ELIMINATE_OUTER_JOIN' ; -- ELIMINATE_OUTER_JOIN VARCHAR2(240)
  EMPTY := 'EMPTY' ; -- EMPTY VARCHAR2(240)
  ENABLE := 'ENABLE' ; -- ENABLE VARCHAR2(240)
  ENCRYPT := 'ENCRYPT' ; -- ENCRYPT VARCHAR2(240)
  ENCRYPTION := 'ENCRYPTION' ; -- ENCRYPTION VARCHAR2(240)
  --SRT END := 'END' ; END VARCHAR2(240)
  END_OUTLINE_DATA := 'END_OUTLINE_DATA' ; -- END_OUTLINE_DATA VARCHAR2(240)
  ENFORCE := 'ENFORCE' ; -- ENFORCE VARCHAR2(240)
  ENFORCED := 'ENFORCED' ; -- ENFORCED VARCHAR2(240)
  ENQUEUE := 'ENQUEUE' ; -- ENQUEUE VARCHAR2(240)
  ENTERPRISE := 'ENTERPRISE' ; -- ENTERPRISE VARCHAR2(240)
  ENTRY := 'ENTRY' ; -- ENTRY VARCHAR2(240)
  ERROR := 'ERROR' ; -- ERROR VARCHAR2(240)
  ERROR_ON_OVERLAP_TIME := 'ERROR_ON_OVERLAP_TIME' ; -- ERROR_ON_OVERLAP_TIME VARCHAR2(240)
  ERRORS := 'ERRORS' ; -- ERRORS VARCHAR2(240)
  ESCAPE := 'ESCAPE' ; -- ESCAPE VARCHAR2(240)
  ESTIMATE := 'ESTIMATE' ; -- ESTIMATE VARCHAR2(240)
  EVALNAME := 'EVALNAME' ; -- EVALNAME VARCHAR2(240)
  EVALUATION := 'EVALUATION' ; -- EVALUATION VARCHAR2(240)
  EVENTS := 'EVENTS' ; -- EVENTS VARCHAR2(240)
  EXCEPT := 'EXCEPT' ; -- EXCEPT VARCHAR2(240)
  EXCEPTIONS := 'EXCEPTIONS' ; -- EXCEPTIONS VARCHAR2(240)
  EXCHANGE := 'EXCHANGE' ; -- EXCHANGE VARCHAR2(240)
  EXCLUDING := 'EXCLUDING' ; -- EXCLUDING VARCHAR2(240)
  EXECUTE := 'EXECUTE' ; -- EXECUTE VARCHAR2(240)
  EXEMPT := 'EXEMPT' ; -- EXEMPT VARCHAR2(240)
  EXPAND_GSET_TO_UNION := 'EXPAND_GSET_TO_UNION' ; -- EXPAND_GSET_TO_UNION VARCHAR2(240)
  EXPIRE := 'EXPIRE' ; -- EXPIRE VARCHAR2(240)
  EXPLAIN := 'EXPLAIN' ; -- EXPLAIN VARCHAR2(240)
  EXPLOSION := 'EXPLOSION' ; -- EXPLOSION VARCHAR2(240)
  EXPORT := 'EXPORT' ; -- EXPORT VARCHAR2(240)
  EXPR_CORR_CHECK := 'EXPR_CORR_CHECK' ; -- EXPR_CORR_CHECK VARCHAR2(240)
  --SRT 20110508 EXTENDS := 'EXTENDS' ; -- EXTENDS VARCHAR2(240)
  EXTENT := 'EXTENT' ; -- EXTENT VARCHAR2(240)
  EXTENTS := 'EXTENTS' ; -- EXTENTS VARCHAR2(240)
  EXTERNAL := 'EXTERNAL' ; -- EXTERNAL VARCHAR2(240)
  EXTERNALLY := 'EXTERNALLY' ; -- EXTERNALLY VARCHAR2(240)
  EXTRACT := 'EXTRACT' ; -- EXTRACT VARCHAR2(240)
  FACT := 'FACT' ; -- FACT VARCHAR2(240)
  FAILED := 'FAILED' ; -- FAILED VARCHAR2(240)
  FAILED_LOGIN_ATTEMPTS := 'FAILED_LOGIN_ATTEMPTS' ; -- FAILED_LOGIN_ATTEMPTS VARCHAR2(240)
  FAILGROUP := 'FAILGROUP' ; -- FAILGROUP VARCHAR2(240)
  FAST := 'FAST' ; -- FAST VARCHAR2(240)
  FBTSCAN := 'FBTSCAN' ; -- FBTSCAN VARCHAR2(240)
  FIC_CIV := 'FIC_CIV' ; -- FIC_CIV VARCHAR2(240)
  FIC_PIV := 'FIC_PIV' ; -- FIC_PIV VARCHAR2(240)
  FILE := 'FILE' ; -- FILE VARCHAR2(240)
  FILTER := 'FILTER' ; -- FILTER VARCHAR2(240)
  FINAL := 'FINAL' ; -- FINAL VARCHAR2(240)
  FINE := 'FINE' ; -- FINE VARCHAR2(240)
  FINISH := 'FINISH' ; -- FINISH VARCHAR2(240)
  FIRST := 'FIRST' ; -- FIRST VARCHAR2(240)
  FIRST_ROWS := 'FIRST_ROWS' ; -- FIRST_ROWS VARCHAR2(240)
  FLAGGER := 'FLAGGER' ; -- FLAGGER VARCHAR2(240)
  FLASHBACK := 'FLASHBACK' ; -- FLASHBACK VARCHAR2(240)
  FLOB := 'FLOB' ; -- FLOB VARCHAR2(240)
  FLUSH := 'FLUSH' ; -- FLUSH VARCHAR2(240)
  FOLLOWING := 'FOLLOWING' ; -- FOLLOWING VARCHAR2(240)
  -- := '--' ; -- -- FORCE VARCHAR2(240)
  FORCE_XML_QUERY_REWRITE := 'FORCE_XML_QUERY_REWRITE' ; -- FORCE_XML_QUERY_REWRITE VARCHAR2(240)
  FOREIGN := 'FOREIGN' ; -- FOREIGN VARCHAR2(240)
  FREELIST := 'FREELIST' ; -- FREELIST VARCHAR2(240)
  FREELISTS := 'FREELISTS' ; -- FREELISTS VARCHAR2(240)
  FREEPOOLS := 'FREEPOOLS' ; -- FREEPOOLS VARCHAR2(240)
  FRESH := 'FRESH' ; -- FRESH VARCHAR2(240)
  FULL := 'FULL' ; -- FULL VARCHAR2(240)
  --SRT FUNCTION := 'FUNCTION' ; FUNCTION VARCHAR2(240)
  FUNCTIONS := 'FUNCTIONS' ; -- FUNCTIONS VARCHAR2(240)
  G := 'G' ; -- G VARCHAR2(240)
  GATHER_PLAN_STATISTICS := 'GATHER_PLAN_STATISTICS' ; -- GATHER_PLAN_STATISTICS VARCHAR2(240)
  GBY_CONC_ROLLUP := 'GBY_CONC_ROLLUP' ; -- GBY_CONC_ROLLUP VARCHAR2(240)
  GENERATED := 'GENERATED' ; -- GENERATED VARCHAR2(240)
  GLOBAL := 'GLOBAL' ; -- GLOBAL VARCHAR2(240)
  GLOBAL_NAME := 'GLOBAL_NAME' ; -- GLOBAL_NAME VARCHAR2(240)
  GLOBAL_TOPIC_ENABLED := 'GLOBAL_TOPIC_ENABLED' ; -- GLOBAL_TOPIC_ENABLED VARCHAR2(240)
  GLOBALLY := 'GLOBALLY' ; -- GLOBALLY VARCHAR2(240)
  GROUP_BY := 'GROUP_BY' ; -- GROUP_BY VARCHAR2(240)
  GROUPING := 'GROUPING' ; -- GROUPING VARCHAR2(240)
  GROUPS := 'GROUPS' ; -- GROUPS VARCHAR2(240)
  GUARANTEE := 'GUARANTEE' ; -- GUARANTEE VARCHAR2(240)
  GUARANTEED := 'GUARANTEED' ; -- GUARANTEED VARCHAR2(240)
  GUARD := 'GUARD' ; -- GUARD VARCHAR2(240)
  HASH := 'HASH' ; -- HASH VARCHAR2(240)
  HASH_AJ := 'HASH_AJ' ; -- HASH_AJ VARCHAR2(240)
  HASH_SJ := 'HASH_SJ' ; -- HASH_SJ VARCHAR2(240)
  HASHKEYS := 'HASHKEYS' ; -- HASHKEYS VARCHAR2(240)
  HEADER := 'HEADER' ; -- HEADER VARCHAR2(240)
  --SRT 20110508 HEAP := 'HEAP' ; -- HEAP VARCHAR2(240)
  HIERARCHY := 'HIERARCHY' ; -- HIERARCHY VARCHAR2(240)
  HIGH := 'HIGH' ; -- HIGH VARCHAR2(240)
  HINTSET_BEGIN := 'HINTSET_BEGIN' ; -- HINTSET_BEGIN VARCHAR2(240)
  HINTSET_END := 'HINTSET_END' ; -- HINTSET_END VARCHAR2(240)
  HOUR := 'HOUR' ; -- HOUR VARCHAR2(240)
  HWM_BROKERED := 'HWM_BROKERED' ; -- HWM_BROKERED VARCHAR2(240)
  ID := 'ID' ; -- ID VARCHAR2(240)
  IDENTIFIER := 'IDENTIFIER' ; -- IDENTIFIER VARCHAR2(240)
  IDENTITY := 'IDENTITY' ; -- IDENTITY VARCHAR2(240)
  IDGENERATORS := 'IDGENERATORS' ; -- IDGENERATORS VARCHAR2(240)
  IDLE_TIME := 'IDLE_TIME' ; -- IDLE_TIME VARCHAR2(240)
  --SRT 20110508 IF := 'IF' ; -- IF VARCHAR2(240)
  IGNORE := 'IGNORE' ; -- IGNORE VARCHAR2(240)
  IGNORE_OPTIM_EMBEDDED_HINTS := 'IGNORE_OPTIM_EMBEDDED_HINTS' ; -- IGNORE_OPTIM_EMBEDDED_HINTS VARCHAR2(240)
  IGNORE_WHERE_CLAUSE := 'IGNORE_WHERE_CLAUSE' ; -- IGNORE_WHERE_CLAUSE VARCHAR2(240)
  --SRT 20110508 IMMEDIATE := 'IMMEDIATE' ; -- IMMEDIATE VARCHAR2(240)
  IMPORT := 'IMPORT' ; -- IMPORT VARCHAR2(240)
  IN_MEMORY_METADATA := 'IN_MEMORY_METADATA' ; -- IN_MEMORY_METADATA VARCHAR2(240)
  INCLUDE_VERSION := 'INCLUDE_VERSION' ; -- INCLUDE_VERSION VARCHAR2(240)
  -- := '--' ; -- -- INCLUDING VARCHAR2(240)
  INCREMENT := 'INCREMENT' ; -- INCREMENT VARCHAR2(240)
  INCREMENTAL := 'INCREMENTAL' ; -- INCREMENTAL VARCHAR2(240)
  INDEX_ASC := 'INDEX_ASC' ; -- INDEX_ASC VARCHAR2(240)
  INDEX_COMBINE := 'INDEX_COMBINE' ; -- INDEX_COMBINE VARCHAR2(240)
  INDEX_DESC := 'INDEX_DESC' ; -- INDEX_DESC VARCHAR2(240)
  INDEX_FFS := 'INDEX_FFS' ; -- INDEX_FFS VARCHAR2(240)
  INDEX_FILTER := 'INDEX_FILTER' ; -- INDEX_FILTER VARCHAR2(240)
  INDEX_JOIN := 'INDEX_JOIN' ; -- INDEX_JOIN VARCHAR2(240)
  INDEX_ROWS := 'INDEX_ROWS' ; -- INDEX_ROWS VARCHAR2(240)
  INDEX_RRS := 'INDEX_RRS' ; -- INDEX_RRS VARCHAR2(240)
  INDEX_RS := 'INDEX_RS' ; -- INDEX_RS VARCHAR2(240)
  INDEX_RS_ASC := 'INDEX_RS_ASC' ; -- INDEX_RS_ASC VARCHAR2(240)
  INDEX_RS_DESC := 'INDEX_RS_DESC' ; -- INDEX_RS_DESC VARCHAR2(240)
  INDEX_SCAN := 'INDEX_SCAN' ; -- INDEX_SCAN VARCHAR2(240)
  INDEX_SKIP_SCAN := 'INDEX_SKIP_SCAN' ; -- INDEX_SKIP_SCAN VARCHAR2(240)
  INDEX_SS := 'INDEX_SS' ; -- INDEX_SS VARCHAR2(240)
  INDEX_SS_ASC := 'INDEX_SS_ASC' ; -- INDEX_SS_ASC VARCHAR2(240)
  INDEX_SS_DESC := 'INDEX_SS_DESC' ; -- INDEX_SS_DESC VARCHAR2(240)
  INDEX_STATS := 'INDEX_STATS' ; -- INDEX_STATS VARCHAR2(240)
  INDEXED := 'INDEXED' ; -- INDEXED VARCHAR2(240)
  --SRT 20120430  INDEXES := 'INDEXES' ; -- INDEXES VARCHAR2(240)
  INDEXTYPE := 'INDEXTYPE' ; -- INDEXTYPE VARCHAR2(240)
  INDEXTYPES := 'INDEXTYPES' ; -- INDEXTYPES VARCHAR2(240)
  --SRT 20110508 INDICATOR := 'INDICATOR' ; -- INDICATOR VARCHAR2(240)
  INFINITE := 'INFINITE' ; -- INFINITE VARCHAR2(240)
  INFORMATIONAL := 'INFORMATIONAL' ; -- INFORMATIONAL VARCHAR2(240)
  INITIAL := 'INITIAL' ; -- INITIAL VARCHAR2(240)
  INITIALIZED := 'INITIALIZED' ; -- INITIALIZED VARCHAR2(240)
  INITIALLY := 'INITIALLY' ; -- INITIALLY VARCHAR2(240)
  INITRANS := 'INITRANS' ; -- INITRANS VARCHAR2(240)
  INLINE := 'INLINE' ; -- INLINE VARCHAR2(240)
  INLINE_XMLTYPE_NT := 'INLINE_XMLTYPE_NT' ; -- INLINE_XMLTYPE_NT VARCHAR2(240)
  INNER := 'INNER' ; -- INNER VARCHAR2(240)
  INSTANCE := 'INSTANCE' ; -- INSTANCE VARCHAR2(240)
  INSTANCES := 'INSTANCES' ; -- INSTANCES VARCHAR2(240)
  INSTANTIABLE := 'INSTANTIABLE' ; -- INSTANTIABLE VARCHAR2(240)
  INSTANTLY := 'INSTANTLY' ; -- INSTANTLY VARCHAR2(240)
  INSTEAD := 'INSTEAD' ; -- INSTEAD VARCHAR2(240)
  INT := 'INT' ; -- INT VARCHAR2(240)
  INTERMEDIATE := 'INTERMEDIATE' ; -- INTERMEDIATE VARCHAR2(240)
  INTERNAL_CONVERT := 'INTERNAL_CONVERT' ; -- INTERNAL_CONVERT VARCHAR2(240)
  INTERNAL_USE := 'INTERNAL_USE' ; -- INTERNAL_USE VARCHAR2(240)
  INTERPRETED := 'INTERPRETED' ; -- INTERPRETED VARCHAR2(240)
  --SRT 20110508 INTERVAL := 'INTERVAL' ; -- INTERVAL VARCHAR2(240)
  INVALIDATE := 'INVALIDATE' ; -- INVALIDATE VARCHAR2(240)
  --SRT 20110508 ISOLATION := 'ISOLATION' ; -- ISOLATION VARCHAR2(240)
  ISOLATION_LEVEL := 'ISOLATION_LEVEL' ; -- ISOLATION_LEVEL VARCHAR2(240)
  ITERATE := 'ITERATE' ; -- ITERATE VARCHAR2(240)
  ITERATION_NUMBER := 'ITERATION_NUMBER' ; -- ITERATION_NUMBER VARCHAR2(240)
  --SRT 20110508 JAVA := 'JAVA' ; -- JAVA VARCHAR2(240)
  JOB := 'JOB' ; -- JOB VARCHAR2(240)
  JOIN := 'JOIN' ; -- JOIN VARCHAR2(240)
  K := 'K' ; -- K VARCHAR2(240)
  KEEP := 'KEEP' ; -- KEEP VARCHAR2(240)
  KERBEROS := 'KERBEROS' ; -- KERBEROS VARCHAR2(240)
  KEY := 'KEY' ; -- KEY VARCHAR2(240)
  KEY_LENGTH := 'KEY_LENGTH' ; -- KEY_LENGTH VARCHAR2(240)
  KEYS := 'KEYS' ; -- KEYS VARCHAR2(240)
  KEYSIZE := 'KEYSIZE' ; -- KEYSIZE VARCHAR2(240)
  KILL := 'KILL' ; -- KILL VARCHAR2(240)
  LAST := 'LAST' ; -- LAST VARCHAR2(240)
  LATERAL := 'LATERAL' ; -- LATERAL VARCHAR2(240)
  LAYER := 'LAYER' ; -- LAYER VARCHAR2(240)
  LDAP_REG_SYNC_INTERVAL := 'LDAP_REG_SYNC_INTERVAL' ; -- LDAP_REG_SYNC_INTERVAL VARCHAR2(240)
  LDAP_REGISTRATION := 'LDAP_REGISTRATION' ; -- LDAP_REGISTRATION VARCHAR2(240)
  LDAP_REGISTRATION_ENABLED := 'LDAP_REGISTRATION_ENABLED' ; -- LDAP_REGISTRATION_ENABLED VARCHAR2(240)
  LEADING := 'LEADING' ; -- LEADING VARCHAR2(240)
  LEFT := 'LEFT' ; -- LEFT VARCHAR2(240)
  LENGTH := 'LENGTH' ; -- LENGTH VARCHAR2(240)
  LESS := 'LESS' ; -- LESS VARCHAR2(240)
  --SRT 20110508 LEVEL := 'LEVEL' ; -- LEVEL VARCHAR2(240)
  LEVELS := 'LEVELS' ; -- LEVELS VARCHAR2(240)
  LIBRARY := 'LIBRARY' ; -- LIBRARY VARCHAR2(240)
  LIKE_EXPAND := 'LIKE_EXPAND' ; -- LIKE_EXPAND VARCHAR2(240)
  LIKE2 := 'LIKE2' ; -- LIKE2 VARCHAR2(240)
  LIKE4 := 'LIKE4' ; -- LIKE4 VARCHAR2(240)
  LIKEC := 'LIKEC' ; -- LIKEC VARCHAR2(240)
  LIMIT := 'LIMIT' ; -- LIMIT VARCHAR2(240)
  LINK := 'LINK' ; -- LINK VARCHAR2(240)
  LIST := 'LIST' ; -- LIST VARCHAR2(240)
  LOB := 'LOB' ; -- LOB VARCHAR2(240)
  LOCAL := 'LOCAL' ; -- LOCAL VARCHAR2(240)
  LOCAL_INDEXES := 'LOCAL_INDEXES' ; -- LOCAL_INDEXES VARCHAR2(240)
  LOCALTIME := 'LOCALTIME' ; -- LOCALTIME VARCHAR2(240)
  LOCALTIMESTAMP := 'LOCALTIMESTAMP' ; -- LOCALTIMESTAMP VARCHAR2(240)
  LOCATION := 'LOCATION' ; -- LOCATION VARCHAR2(240)
  LOCATOR := 'LOCATOR' ; -- LOCATOR VARCHAR2(240)
  LOCKED := 'LOCKED' ; -- LOCKED VARCHAR2(240)
  LOG := 'LOG' ; -- LOG VARCHAR2(240)
  LOGFILE := 'LOGFILE' ; -- LOGFILE VARCHAR2(240)
  LOGGING := 'LOGGING' ; -- LOGGING VARCHAR2(240)
  LOGICAL := 'LOGICAL' ; -- LOGICAL VARCHAR2(240)
  LOGICAL_READS_PER_CALL := 'LOGICAL_READS_PER_CALL' ; -- LOGICAL_READS_PER_CALL VARCHAR2(240)
  LOGICAL_READS_PER_SESSION := 'LOGICAL_READS_PER_SESSION' ; -- LOGICAL_READS_PER_SESSION VARCHAR2(240)
  LOGOFF := 'LOGOFF' ; -- LOGOFF VARCHAR2(240)
  LOGON := 'LOGON' ; -- LOGON VARCHAR2(240)
  M := 'M' ; -- M VARCHAR2(240)
  MAIN := 'MAIN' ; -- MAIN VARCHAR2(240)
  MANAGE := 'MANAGE' ; -- MANAGE VARCHAR2(240)
  MANAGED := 'MANAGED' ; -- MANAGED VARCHAR2(240)
  MANAGEMENT := 'MANAGEMENT' ; -- MANAGEMENT VARCHAR2(240)
  MANUAL := 'MANUAL' ; -- MANUAL VARCHAR2(240)
  MAP := 'MAP' ; -- MAP VARCHAR2(240)
  MAPPING := 'MAPPING' ; -- MAPPING VARCHAR2(240)
  MASTER := 'MASTER' ; -- MASTER VARCHAR2(240)
  MATCHED := 'MATCHED' ; -- MATCHED VARCHAR2(240)
  MATERIALIZE := 'MATERIALIZE' ; -- MATERIALIZE VARCHAR2(240)
  MATERIALIZED := 'MATERIALIZED' ; -- MATERIALIZED VARCHAR2(240)
  --SRT 20110508 MAX := 'MAX' ; -- MAX VARCHAR2(240)
  MAXARCHLOGS := 'MAXARCHLOGS' ; -- MAXARCHLOGS VARCHAR2(240)
  MAXDATAFILES := 'MAXDATAFILES' ; -- MAXDATAFILES VARCHAR2(240)
  MAXEXTENTS := 'MAXEXTENTS' ; -- MAXEXTENTS VARCHAR2(240)
  MAXIMIZE := 'MAXIMIZE' ; -- MAXIMIZE VARCHAR2(240)
  MAXINSTANCES := 'MAXINSTANCES' ; -- MAXINSTANCES VARCHAR2(240)
  MAXLOGFILES := 'MAXLOGFILES' ; -- MAXLOGFILES VARCHAR2(240)
  MAXLOGHISTORY := 'MAXLOGHISTORY' ; -- MAXLOGHISTORY VARCHAR2(240)
  MAXLOGMEMBERS := 'MAXLOGMEMBERS' ; -- MAXLOGMEMBERS VARCHAR2(240)
  MAXSIZE := 'MAXSIZE' ; -- MAXSIZE VARCHAR2(240)
  MAXTRANS := 'MAXTRANS' ; -- MAXTRANS VARCHAR2(240)
  MAXVALUE := 'MAXVALUE' ; -- MAXVALUE VARCHAR2(240)
  MEASURES := 'MEASURES' ; -- MEASURES VARCHAR2(240)
  MEMBER := 'MEMBER' ; -- MEMBER VARCHAR2(240)
  MEMORY := 'MEMORY' ; -- MEMORY VARCHAR2(240)
  MERGE := 'MERGE' ; -- MERGE VARCHAR2(240)
  MERGE_AJ := 'MERGE_AJ' ; -- MERGE_AJ VARCHAR2(240)
  MERGE_CONST_ON := 'MERGE_CONST_ON' ; -- MERGE_CONST_ON VARCHAR2(240)
  MERGE_SJ := 'MERGE_SJ' ; -- MERGE_SJ VARCHAR2(240)
  METHOD := 'METHOD' ; -- METHOD VARCHAR2(240)
  MIGRATE := 'MIGRATE' ; -- MIGRATE VARCHAR2(240)
  --SRT 20110508 MIN := 'MIN' ; -- MIN VARCHAR2(240)
  MINEXTENTS := 'MINEXTENTS' ; -- MINEXTENTS VARCHAR2(240)
  MINIMIZE := 'MINIMIZE' ; -- MINIMIZE VARCHAR2(240)
  MINIMUM := 'MINIMUM' ; -- MINIMUM VARCHAR2(240)
  MINUS_NULL := 'MINUS_NULL' ; -- MINUS_NULL VARCHAR2(240)
  MINUTE := 'MINUTE' ; -- MINUTE VARCHAR2(240)
  MINVALUE := 'MINVALUE' ; -- MINVALUE VARCHAR2(240)
  MIRROR := 'MIRROR' ; -- MIRROR VARCHAR2(240)
  --SRT 20110508 MLSLABEL := 'MLSLABEL' ; -- MLSLABEL VARCHAR2(240)
  MODEL := 'MODEL' ; -- MODEL VARCHAR2(240)
  MODEL_COMPILE_SUBQUERY := 'MODEL_COMPILE_SUBQUERY' ; -- MODEL_COMPILE_SUBQUERY VARCHAR2(240)
  MODEL_DONTVERIFY_UNIQUENESS := 'MODEL_DONTVERIFY_UNIQUENESS' ; -- MODEL_DONTVERIFY_UNIQUENESS VARCHAR2(240)
  MODEL_DYNAMIC_SUBQUERY := 'MODEL_DYNAMIC_SUBQUERY' ; -- MODEL_DYNAMIC_SUBQUERY VARCHAR2(240)
  MODEL_MIN_ANALYSIS := 'MODEL_MIN_ANALYSIS' ; -- MODEL_MIN_ANALYSIS VARCHAR2(240)
  MODEL_NO_ANALYSIS := 'MODEL_NO_ANALYSIS' ; -- MODEL_NO_ANALYSIS VARCHAR2(240)
  MODEL_PBY := 'MODEL_PBY' ; -- MODEL_PBY VARCHAR2(240)
  MODEL_PUSH_REF := 'MODEL_PUSH_REF' ; -- MODEL_PUSH_REF VARCHAR2(240)
  MODIFY := 'MODIFY' ; -- MODIFY VARCHAR2(240)
  MONITORING := 'MONITORING' ; -- MONITORING VARCHAR2(240)
  MONTH := 'MONTH' ; -- MONTH VARCHAR2(240)
  MOUNT := 'MOUNT' ; -- MOUNT VARCHAR2(240)
  MOVE := 'MOVE' ; -- MOVE VARCHAR2(240)
  MOVEMENT := 'MOVEMENT' ; -- MOVEMENT VARCHAR2(240)
  MULTISET := 'MULTISET' ; -- MULTISET VARCHAR2(240)
  MV_MERGE := 'MV_MERGE' ; -- MV_MERGE VARCHAR2(240)
  NAME := 'NAME' ; -- NAME VARCHAR2(240)
  NAMED := 'NAMED' ; -- NAMED VARCHAR2(240)
  NAN := 'NAN' ; -- NAN VARCHAR2(240)
  NATIONAL := 'NATIONAL' ; -- NATIONAL VARCHAR2(240)
  NATIVE := 'NATIVE' ; -- NATIVE VARCHAR2(240)
  NATIVE_FULL_OUTER_JOIN := 'NATIVE_FULL_OUTER_JOIN' ; -- NATIVE_FULL_OUTER_JOIN VARCHAR2(240)
  --SRT 20110508 NATURAL := 'NATURAL' ; -- NATURAL VARCHAR2(240)
  NAV := 'NAV' ; -- NAV VARCHAR2(240)
  NCHAR := 'NCHAR' ; -- NCHAR VARCHAR2(240)
  NCHAR_CS := 'NCHAR_CS' ; -- NCHAR_CS VARCHAR2(240)
  NCLOB := 'NCLOB' ; -- NCLOB VARCHAR2(240)
  NEEDED := 'NEEDED' ; -- NEEDED VARCHAR2(240)
  NESTED := 'NESTED' ; -- NESTED VARCHAR2(240)
  NESTED_TABLE_FAST_INSERT := 'NESTED_TABLE_FAST_INSERT' ; -- NESTED_TABLE_FAST_INSERT VARCHAR2(240)
  NESTED_TABLE_GET_REFS := 'NESTED_TABLE_GET_REFS' ; -- NESTED_TABLE_GET_REFS VARCHAR2(240)
  NESTED_TABLE_ID := 'NESTED_TABLE_ID' ; -- NESTED_TABLE_ID VARCHAR2(240)
  NESTED_TABLE_SET_REFS := 'NESTED_TABLE_SET_REFS' ; -- NESTED_TABLE_SET_REFS VARCHAR2(240)
  NESTED_TABLE_SET_SETID := 'NESTED_TABLE_SET_SETID' ; -- NESTED_TABLE_SET_SETID VARCHAR2(240)
  NETWORK := 'NETWORK' ; -- NETWORK VARCHAR2(240)
  NEVER := 'NEVER' ; -- NEVER VARCHAR2(240)
  NEW := 'NEW' ; -- NEW VARCHAR2(240)
  NEXT := 'NEXT' ; -- NEXT VARCHAR2(240)
  NL_AJ := 'NL_AJ' ; -- NL_AJ VARCHAR2(240)
  NL_SJ := 'NL_SJ' ; -- NL_SJ VARCHAR2(240)
  NLS_CALENDAR := 'NLS_CALENDAR' ; -- NLS_CALENDAR VARCHAR2(240)
  NLS_CHARACTERSET := 'NLS_CHARACTERSET' ; -- NLS_CHARACTERSET VARCHAR2(240)
  NLS_COMP := 'NLS_COMP' ; -- NLS_COMP VARCHAR2(240)
  NLS_CURRENCY := 'NLS_CURRENCY' ; -- NLS_CURRENCY VARCHAR2(240)
  NLS_DATE_FORMAT := 'NLS_DATE_FORMAT' ; -- NLS_DATE_FORMAT VARCHAR2(240)
  NLS_DATE_LANGUAGE := 'NLS_DATE_LANGUAGE' ; -- NLS_DATE_LANGUAGE VARCHAR2(240)
  NLS_ISO_CURRENCY := 'NLS_ISO_CURRENCY' ; -- NLS_ISO_CURRENCY VARCHAR2(240)
  NLS_LANG := 'NLS_LANG' ; -- NLS_LANG VARCHAR2(240)
  NLS_LANGUAGE := 'NLS_LANGUAGE' ; -- NLS_LANGUAGE VARCHAR2(240)
  NLS_LENGTH_SEMANTICS := 'NLS_LENGTH_SEMANTICS' ; -- NLS_LENGTH_SEMANTICS VARCHAR2(240)
  NLS_NCHAR_CONV_EXCP := 'NLS_NCHAR_CONV_EXCP' ; -- NLS_NCHAR_CONV_EXCP VARCHAR2(240)
  NLS_NUMERIC_CHARACTERS := 'NLS_NUMERIC_CHARACTERS' ; -- NLS_NUMERIC_CHARACTERS VARCHAR2(240)
  NLS_SORT := 'NLS_SORT' ; -- NLS_SORT VARCHAR2(240)
  NLS_SPECIAL_CHARS := 'NLS_SPECIAL_CHARS' ; -- NLS_SPECIAL_CHARS VARCHAR2(240)
  NLS_TERRITORY := 'NLS_TERRITORY' ; -- NLS_TERRITORY VARCHAR2(240)
  NO := 'NO' ; -- NO VARCHAR2(240)
  NO_ACCESS := 'NO_ACCESS' ; -- NO_ACCESS VARCHAR2(240)
  NO_BASETABLE_MULTIMV_REWRITE := 'NO_BASETABLE_MULTIMV_REWRITE' ; -- NO_BASETABLE_MULTIMV_REWRITE VARCHAR2(240)
  NO_BUFFER := 'NO_BUFFER' ; -- NO_BUFFER VARCHAR2(240)
  NO_CARTESIAN := 'NO_CARTESIAN' ; -- NO_CARTESIAN VARCHAR2(240)
  NO_CONNECT_BY_COST_BASED := 'NO_CONNECT_BY_COST_BASED' ; -- NO_CONNECT_BY_COST_BASED VARCHAR2(240)
  NO_CONNECT_BY_FILTERING := 'NO_CONNECT_BY_FILTERING' ; -- NO_CONNECT_BY_FILTERING VARCHAR2(240)
  NO_CPU_COSTING := 'NO_CPU_COSTING' ; -- NO_CPU_COSTING VARCHAR2(240)
  NO_ELIMINATE_JOIN := 'NO_ELIMINATE_JOIN' ; -- NO_ELIMINATE_JOIN VARCHAR2(240)
  NO_ELIMINATE_OBY := 'NO_ELIMINATE_OBY' ; -- NO_ELIMINATE_OBY VARCHAR2(240)
  NO_ELIMINATE_OUTER_JOIN := 'NO_ELIMINATE_OUTER_JOIN' ; -- NO_ELIMINATE_OUTER_JOIN VARCHAR2(240)
  NO_EXPAND := 'NO_EXPAND' ; -- NO_EXPAND VARCHAR2(240)
  NO_EXPAND_GSET_TO_UNION := 'NO_EXPAND_GSET_TO_UNION' ; -- NO_EXPAND_GSET_TO_UNION VARCHAR2(240)
  NO_FACT := 'NO_FACT' ; -- NO_FACT VARCHAR2(240)
  NO_FILTERING := 'NO_FILTERING' ; -- NO_FILTERING VARCHAR2(240)
  NO_INDEX := 'NO_INDEX' ; -- NO_INDEX VARCHAR2(240)
  NO_INDEX_FFS := 'NO_INDEX_FFS' ; -- NO_INDEX_FFS VARCHAR2(240)
  NO_INDEX_RS := 'NO_INDEX_RS' ; -- NO_INDEX_RS VARCHAR2(240)
  NO_INDEX_SS := 'NO_INDEX_SS' ; -- NO_INDEX_SS VARCHAR2(240)
  NO_MERGE := 'NO_MERGE' ; -- NO_MERGE VARCHAR2(240)
  NO_MODEL_PUSH_REF := 'NO_MODEL_PUSH_REF' ; -- NO_MODEL_PUSH_REF VARCHAR2(240)
  NO_MONITORING := 'NO_MONITORING' ; -- NO_MONITORING VARCHAR2(240)
  NO_MULTIMV_REWRITE := 'NO_MULTIMV_REWRITE' ; -- NO_MULTIMV_REWRITE VARCHAR2(240)
  NO_NATIVE_FULL_OUTER_JOIN := 'NO_NATIVE_FULL_OUTER_JOIN' ; -- NO_NATIVE_FULL_OUTER_JOIN VARCHAR2(240)
  NO_ORDER_ROLLUPS := 'NO_ORDER_ROLLUPS' ; -- NO_ORDER_ROLLUPS VARCHAR2(240)
  NO_PARALLEL := 'NO_PARALLEL' ; -- NO_PARALLEL VARCHAR2(240)
  NO_PARALLEL_INDEX := 'NO_PARALLEL_INDEX' ; -- NO_PARALLEL_INDEX VARCHAR2(240)
  NO_PARTIAL_COMMIT := 'NO_PARTIAL_COMMIT' ; -- NO_PARTIAL_COMMIT VARCHAR2(240)
  NO_PRUNE_GSETS := 'NO_PRUNE_GSETS' ; -- NO_PRUNE_GSETS VARCHAR2(240)
  NO_PULL_PRED := 'NO_PULL_PRED' ; -- NO_PULL_PRED VARCHAR2(240)
  NO_PUSH_PRED := 'NO_PUSH_PRED' ; -- NO_PUSH_PRED VARCHAR2(240)
  NO_PUSH_SUBQ := 'NO_PUSH_SUBQ' ; -- NO_PUSH_SUBQ VARCHAR2(240)
  NO_PX_JOIN_FILTER := 'NO_PX_JOIN_FILTER' ; -- NO_PX_JOIN_FILTER VARCHAR2(240)
  NO_QKN_BUFF := 'NO_QKN_BUFF' ; -- NO_QKN_BUFF VARCHAR2(240)
  NO_QUERY_TRANSFORMATION := 'NO_QUERY_TRANSFORMATION' ; -- NO_QUERY_TRANSFORMATION VARCHAR2(240)
  NO_REF_CASCADE := 'NO_REF_CASCADE' ; -- NO_REF_CASCADE VARCHAR2(240)
  NO_REWRITE := 'NO_REWRITE' ; -- NO_REWRITE VARCHAR2(240)
  NO_SEMIJOIN := 'NO_SEMIJOIN' ; -- NO_SEMIJOIN VARCHAR2(240)
  NO_SET_TO_JOIN := 'NO_SET_TO_JOIN' ; -- NO_SET_TO_JOIN VARCHAR2(240)
  NO_SQL_TUNE := 'NO_SQL_TUNE' ; -- NO_SQL_TUNE VARCHAR2(240)
  NO_STAR_TRANSFORMATION := 'NO_STAR_TRANSFORMATION' ; -- NO_STAR_TRANSFORMATION VARCHAR2(240)
  NO_STATS_GSETS := 'NO_STATS_GSETS' ; -- NO_STATS_GSETS VARCHAR2(240)
  NO_SWAP_JOIN_INPUTS := 'NO_SWAP_JOIN_INPUTS' ; -- NO_SWAP_JOIN_INPUTS VARCHAR2(240)
  NO_TEMP_TABLE := 'NO_TEMP_TABLE' ; -- NO_TEMP_TABLE VARCHAR2(240)
  NO_UNNEST := 'NO_UNNEST' ; -- NO_UNNEST VARCHAR2(240)
  NO_USE_HASH := 'NO_USE_HASH' ; -- NO_USE_HASH VARCHAR2(240)
  NO_USE_HASH_AGGREGATION := 'NO_USE_HASH_AGGREGATION' ; -- NO_USE_HASH_AGGREGATION VARCHAR2(240)
  NO_USE_MERGE := 'NO_USE_MERGE' ; -- NO_USE_MERGE VARCHAR2(240)
  NO_USE_NL := 'NO_USE_NL' ; -- NO_USE_NL VARCHAR2(240)
  NO_XML_DML_REWRITE := 'NO_XML_DML_REWRITE' ; -- NO_XML_DML_REWRITE VARCHAR2(240)
  NO_XML_QUERY_REWRITE := 'NO_XML_QUERY_REWRITE' ; -- NO_XML_QUERY_REWRITE VARCHAR2(240)
  NOAPPEND := 'NOAPPEND' ; -- NOAPPEND VARCHAR2(240)
  NOARCHIVELOG := 'NOARCHIVELOG' ; -- NOARCHIVELOG VARCHAR2(240)
  NOAUDIT := 'NOAUDIT' ; -- NOAUDIT VARCHAR2(240)
  NOCACHE := 'NOCACHE' ; -- NOCACHE VARCHAR2(240)
  NOCPU_COSTING := 'NOCPU_COSTING' ; -- NOCPU_COSTING VARCHAR2(240)
  NOCYCLE := 'NOCYCLE' ; -- NOCYCLE VARCHAR2(240)
  NODELAY := 'NODELAY' ; -- NODELAY VARCHAR2(240)
  NOFORCE := 'NOFORCE' ; -- NOFORCE VARCHAR2(240)
  NOGUARANTEE := 'NOGUARANTEE' ; -- NOGUARANTEE VARCHAR2(240)
  NOLOGGING := 'NOLOGGING' ; -- NOLOGGING VARCHAR2(240)
  NOMAPPING := 'NOMAPPING' ; -- NOMAPPING VARCHAR2(240)
  NOMAXVALUE := 'NOMAXVALUE' ; -- NOMAXVALUE VARCHAR2(240)
  NOMINIMIZE := 'NOMINIMIZE' ; -- NOMINIMIZE VARCHAR2(240)
  NOMINVALUE := 'NOMINVALUE' ; -- NOMINVALUE VARCHAR2(240)
  NOMONITORING := 'NOMONITORING' ; -- NOMONITORING VARCHAR2(240)
  NONE := 'NONE' ; -- NONE VARCHAR2(240)
  NOORDER := 'NOORDER' ; -- NOORDER VARCHAR2(240)
  NOOVERRIDE := 'NOOVERRIDE' ; -- NOOVERRIDE VARCHAR2(240)
  NOPARALLEL := 'NOPARALLEL' ; -- NOPARALLEL VARCHAR2(240)
  NOPARALLEL_INDEX := 'NOPARALLEL_INDEX' ; -- NOPARALLEL_INDEX VARCHAR2(240)
  NORELY := 'NORELY' ; -- NORELY VARCHAR2(240)
  NOREPAIR := 'NOREPAIR' ; -- NOREPAIR VARCHAR2(240)
  NORESETLOGS := 'NORESETLOGS' ; -- NORESETLOGS VARCHAR2(240)
  NOREVERSE := 'NOREVERSE' ; -- NOREVERSE VARCHAR2(240)
  NOREWRITE := 'NOREWRITE' ; -- NOREWRITE VARCHAR2(240)
  NORMAL := 'NORMAL' ; -- NORMAL VARCHAR2(240)
  NOROWDEPENDENCIES := 'NOROWDEPENDENCIES' ; -- NOROWDEPENDENCIES VARCHAR2(240)
  NOSEGMENT := 'NOSEGMENT' ; -- NOSEGMENT VARCHAR2(240)
  NOSORT := 'NOSORT' ; -- NOSORT VARCHAR2(240)
  NOSTRICT := 'NOSTRICT' ; -- NOSTRICT VARCHAR2(240)
  NOSWITCH := 'NOSWITCH' ; -- NOSWITCH VARCHAR2(240)
  NOTHING := 'NOTHING' ; -- NOTHING VARCHAR2(240)
  NOTIFICATION := 'NOTIFICATION' ; -- NOTIFICATION VARCHAR2(240)
  NOVALIDATE := 'NOVALIDATE' ; -- NOVALIDATE VARCHAR2(240)
  NULLS := 'NULLS' ; -- NULLS VARCHAR2(240)
  NUM_INDEX_KEYS := 'NUM_INDEX_KEYS' ; -- NUM_INDEX_KEYS VARCHAR2(240)
  --SRT 20110508 NUMERIC := 'NUMERIC' ; -- NUMERIC VARCHAR2(240)
  NVARCHAR2 := 'NVARCHAR2' ; -- NVARCHAR2 VARCHAR2(240)
  OBJECT := 'OBJECT' ; -- OBJECT VARCHAR2(240)
  OBJNO := 'OBJNO' ; -- OBJNO VARCHAR2(240)
  OBJNO_REUSE := 'OBJNO_REUSE' ; -- OBJNO_REUSE VARCHAR2(240)
  OFF := 'OFF' ; -- OFF VARCHAR2(240)
  OFFLINE := 'OFFLINE' ; -- OFFLINE VARCHAR2(240)
  OID := 'OID' ; -- OID VARCHAR2(240)
  OIDINDEX := 'OIDINDEX' ; -- OIDINDEX VARCHAR2(240)
  OLD := 'OLD' ; -- OLD VARCHAR2(240)
  OLD_PUSH_PRED := 'OLD_PUSH_PRED' ; -- OLD_PUSH_PRED VARCHAR2(240)
  ONLINE := 'ONLINE' ; -- ONLINE VARCHAR2(240)
  ONLY := 'ONLY' ; -- ONLY VARCHAR2(240)
  --SRT 20110508 OPAQUE := 'OPAQUE' ; -- OPAQUE VARCHAR2(240)
  OPAQUE_TRANSFORM := 'OPAQUE_TRANSFORM' ; -- OPAQUE_TRANSFORM VARCHAR2(240)
  OPAQUE_XCANONICAL := 'OPAQUE_XCANONICAL' ; -- OPAQUE_XCANONICAL VARCHAR2(240)
  OPCODE := 'OPCODE' ; -- OPCODE VARCHAR2(240)
  --SRT 20110508 OPEN := 'OPEN' ; -- OPEN VARCHAR2(240)
  OPERATOR := 'OPERATOR' ; -- OPERATOR VARCHAR2(240)
  OPT_ESTIMATE := 'OPT_ESTIMATE' ; -- OPT_ESTIMATE VARCHAR2(240)
  OPT_PARAM := 'OPT_PARAM' ; -- OPT_PARAM VARCHAR2(240)
  OPTIMAL := 'OPTIMAL' ; -- OPTIMAL VARCHAR2(240)
  OPTIMIZER_FEATURES_ENABLE := 'OPTIMIZER_FEATURES_ENABLE' ; -- OPTIMIZER_FEATURES_ENABLE VARCHAR2(240)
  OPTIMIZER_GOAL := 'OPTIMIZER_GOAL' ; -- OPTIMIZER_GOAL VARCHAR2(240)
  OR_EXPAND := 'OR_EXPAND' ; -- OR_EXPAND VARCHAR2(240)
  ORA_ROWSCN := 'ORA_ROWSCN' ; -- ORA_ROWSCN VARCHAR2(240)
  ORDERED := 'ORDERED' ; -- ORDERED VARCHAR2(240)
  ORDERED_PREDICATES := 'ORDERED_PREDICATES' ; -- ORDERED_PREDICATES VARCHAR2(240)
  ORDINALITY := 'ORDINALITY' ; -- ORDINALITY VARCHAR2(240)
  --SRT 20110508 ORGANIZATION := 'ORGANIZATION' ; -- ORGANIZATION VARCHAR2(240)
  OUT_OF_LINE := 'OUT_OF_LINE' ; -- OUT_OF_LINE VARCHAR2(240)
  OUTER := 'OUTER' ; -- OUTER VARCHAR2(240)
  OUTLINE := 'OUTLINE' ; -- OUTLINE VARCHAR2(240)
  OUTLINE_LEAF := 'OUTLINE_LEAF' ; -- OUTLINE_LEAF VARCHAR2(240)
  OVER := 'OVER' ; -- OVER VARCHAR2(240)
  OVERFLOW := 'OVERFLOW' ; -- OVERFLOW VARCHAR2(240)
  OVERFLOW_NOMOVE := 'OVERFLOW_NOMOVE' ; -- OVERFLOW_NOMOVE VARCHAR2(240)
  --SRT 20120430  OVERLAPS := 'OVERLAPS' ; -- OVERLAPS VARCHAR2(240)
  OVERRIDING := 'OVERRIDING' ; -- OVERRIDING VARCHAR2(240)
  OWN := 'OWN' ; -- OWN VARCHAR2(240)
  P := 'P' ; -- P VARCHAR2(240)
  --SRT 20110508 PACKAGE := 'PACKAGE' ; -- PACKAGE VARCHAR2(240)
  PACKAGES := 'PACKAGES' ; -- PACKAGES VARCHAR2(240)
  PARALLEL := 'PARALLEL' ; -- PARALLEL VARCHAR2(240)
  PARALLEL_INDEX := 'PARALLEL_INDEX' ; -- PARALLEL_INDEX VARCHAR2(240)
  PARAMETERS := 'PARAMETERS' ; -- PARAMETERS VARCHAR2(240)
  PARENT := 'PARENT' ; -- PARENT VARCHAR2(240)
  PARITY := 'PARITY' ; -- PARITY VARCHAR2(240)
  PARTIALLY := 'PARTIALLY' ; -- PARTIALLY VARCHAR2(240)
  PARTITION := 'PARTITION' ; -- PARTITION VARCHAR2(240)
  PARTITION_HASH := 'PARTITION_HASH' ; -- PARTITION_HASH VARCHAR2(240)
  PARTITION_LIST := 'PARTITION_LIST' ; -- PARTITION_LIST VARCHAR2(240)
  PARTITION_RANGE := 'PARTITION_RANGE' ; -- PARTITION_RANGE VARCHAR2(240)
  PARTITIONS := 'PARTITIONS' ; -- PARTITIONS VARCHAR2(240)
  PASSING := 'PASSING' ; -- PASSING VARCHAR2(240)
  PASSWORD := 'PASSWORD' ; -- PASSWORD VARCHAR2(240)
  PASSWORD_GRACE_TIME := 'PASSWORD_GRACE_TIME' ; -- PASSWORD_GRACE_TIME VARCHAR2(240)
  PASSWORD_LIFE_TIME := 'PASSWORD_LIFE_TIME' ; -- PASSWORD_LIFE_TIME VARCHAR2(240)
  PASSWORD_LOCK_TIME := 'PASSWORD_LOCK_TIME' ; -- PASSWORD_LOCK_TIME VARCHAR2(240)
  PASSWORD_REUSE_MAX := 'PASSWORD_REUSE_MAX' ; -- PASSWORD_REUSE_MAX VARCHAR2(240)
  PASSWORD_REUSE_TIME := 'PASSWORD_REUSE_TIME' ; -- PASSWORD_REUSE_TIME VARCHAR2(240)
  PASSWORD_VERIFY_FUNCTION := 'PASSWORD_VERIFY_FUNCTION' ; -- PASSWORD_VERIFY_FUNCTION VARCHAR2(240)
  PATH := 'PATH' ; -- PATH VARCHAR2(240)
  PATHS := 'PATHS' ; -- PATHS VARCHAR2(240)
  PCTINCREASE := 'PCTINCREASE' ; -- PCTINCREASE VARCHAR2(240)
  PCTTHRESHOLD := 'PCTTHRESHOLD' ; -- PCTTHRESHOLD VARCHAR2(240)
  PCTUSED := 'PCTUSED' ; -- PCTUSED VARCHAR2(240)
  PCTVERSION := 'PCTVERSION' ; -- PCTVERSION VARCHAR2(240)
  PERCENT := 'PERCENT' ; -- PERCENT VARCHAR2(240)
  PERFORMANCE := 'PERFORMANCE' ; -- PERFORMANCE VARCHAR2(240)
  PERMANENT := 'PERMANENT' ; -- PERMANENT VARCHAR2(240)
  PFILE := 'PFILE' ; -- PFILE VARCHAR2(240)
  PHYSICAL := 'PHYSICAL' ; -- PHYSICAL VARCHAR2(240)
  PIV_GB := 'PIV_GB' ; -- PIV_GB VARCHAR2(240)
  PIV_SSF := 'PIV_SSF' ; -- PIV_SSF VARCHAR2(240)
  PLAN := 'PLAN' ; -- PLAN VARCHAR2(240)
  PLSQL_CCFLAGS := 'PLSQL_CCFLAGS' ; -- PLSQL_CCFLAGS VARCHAR2(240)
  PLSQL_CODE_TYPE := 'PLSQL_CODE_TYPE' ; -- PLSQL_CODE_TYPE VARCHAR2(240)
  PLSQL_DEBUG := 'PLSQL_DEBUG' ; -- PLSQL_DEBUG VARCHAR2(240)
  PLSQL_OPTIMIZE_LEVEL := 'PLSQL_OPTIMIZE_LEVEL' ; -- PLSQL_OPTIMIZE_LEVEL VARCHAR2(240)
  PLSQL_WARNINGS := 'PLSQL_WARNINGS' ; -- PLSQL_WARNINGS VARCHAR2(240)
  POINT := 'POINT' ; -- POINT VARCHAR2(240)
  POLICY := 'POLICY' ; -- POLICY VARCHAR2(240)
  POST_TRANSACTION := 'POST_TRANSACTION' ; -- POST_TRANSACTION VARCHAR2(240)
  POWER := 'POWER' ; -- POWER VARCHAR2(240)
  PQ_DISTRIBUTE := 'PQ_DISTRIBUTE' ; -- PQ_DISTRIBUTE VARCHAR2(240)
  PQ_MAP := 'PQ_MAP' ; -- PQ_MAP VARCHAR2(240)
  PQ_NOMAP := 'PQ_NOMAP' ; -- PQ_NOMAP VARCHAR2(240)
  PREBUILT := 'PREBUILT' ; -- PREBUILT VARCHAR2(240)
  PRECEDING := 'PRECEDING' ; -- PRECEDING VARCHAR2(240)
  --SRT 20110508 PRECISION := 'PRECISION' ; -- PRECISION VARCHAR2(240)
  PRECOMPUTE_SUBQUERY := 'PRECOMPUTE_SUBQUERY' ; -- PRECOMPUTE_SUBQUERY VARCHAR2(240)
  PREPARE := 'PREPARE' ; -- PREPARE VARCHAR2(240)
  PRESENT := 'PRESENT' ; -- PRESENT VARCHAR2(240)
  PRESERVE := 'PRESERVE' ; -- PRESERVE VARCHAR2(240)
  PRESERVE_OID := 'PRESERVE_OID' ; -- PRESERVE_OID VARCHAR2(240)
  PRIMARY := 'PRIMARY' ; -- PRIMARY VARCHAR2(240)
  PRIVATE := 'PRIVATE' ; -- PRIVATE VARCHAR2(240)
  PRIVATE_SGA := 'PRIVATE_SGA' ; -- PRIVATE_SGA VARCHAR2(240)
  PRIVILEGE := 'PRIVILEGE' ; -- PRIVILEGE VARCHAR2(240)
  PRIVILEGES := 'PRIVILEGES' ; -- PRIVILEGES VARCHAR2(240)
  --SRT PROCEDURE := 'PROCEDURE'  ; PROCEDURE VARCHAR2(240)
  PROFILE := 'PROFILE' ; -- PROFILE VARCHAR2(240)
  PROGRAM := 'PROGRAM' ; -- PROGRAM VARCHAR2(240)
  PROJECT := 'PROJECT' ; -- PROJECT VARCHAR2(240)
  PROTECTED := 'PROTECTED' ; -- PROTECTED VARCHAR2(240)
  PROTECTION := 'PROTECTION' ; -- PROTECTION VARCHAR2(240)
  PULL_PRED := 'PULL_PRED' ; -- PULL_PRED VARCHAR2(240)
  PURGE := 'PURGE' ; -- PURGE VARCHAR2(240)
  PUSH_PRED := 'PUSH_PRED' ; -- PUSH_PRED VARCHAR2(240)
  PUSH_SUBQ := 'PUSH_SUBQ' ; -- PUSH_SUBQ VARCHAR2(240)
  PX_GRANULE := 'PX_GRANULE' ; -- PX_GRANULE VARCHAR2(240)
  PX_JOIN_FILTER := 'PX_JOIN_FILTER' ; -- PX_JOIN_FILTER VARCHAR2(240)
  QB_NAME := 'QB_NAME' ; -- QB_NAME VARCHAR2(240)
  QUERY := 'QUERY' ; -- QUERY VARCHAR2(240)
  QUERY_BLOCK := 'QUERY_BLOCK' ; -- QUERY_BLOCK VARCHAR2(240)
  QUEUE := 'QUEUE' ; -- QUEUE VARCHAR2(240)
  QUEUE_CURR := 'QUEUE_CURR' ; -- QUEUE_CURR VARCHAR2(240)
  QUEUE_ROWP := 'QUEUE_ROWP' ; -- QUEUE_ROWP VARCHAR2(240)
  QUIESCE := 'QUIESCE' ; -- QUIESCE VARCHAR2(240)
  QUOTA := 'QUOTA' ; -- QUOTA VARCHAR2(240)
  RANDOM := 'RANDOM' ; -- RANDOM VARCHAR2(240)
  RANGE := 'RANGE' ; -- RANGE VARCHAR2(240)
  RAPIDLY := 'RAPIDLY' ; -- RAPIDLY VARCHAR2(240)
  RBA := 'RBA' ; -- RBA VARCHAR2(240)
  RBO_OUTLINE := 'RBO_OUTLINE' ; -- RBO_OUTLINE VARCHAR2(240)
  READ := 'READ' ; -- READ VARCHAR2(240)
  READS := 'READS' ; -- READS VARCHAR2(240)
  --SRT 20110508 REAL := 'REAL' ; -- REAL VARCHAR2(240)
  REBALANCE := 'REBALANCE' ; -- REBALANCE VARCHAR2(240)
  REBUILD := 'REBUILD' ; -- REBUILD VARCHAR2(240)
  RECORDS_PER_BLOCK := 'RECORDS_PER_BLOCK' ; -- RECORDS_PER_BLOCK VARCHAR2(240)
  RECOVER := 'RECOVER' ; -- RECOVER VARCHAR2(240)
  RECOVERABLE := 'RECOVERABLE' ; -- RECOVERABLE VARCHAR2(240)
  RECOVERY := 'RECOVERY' ; -- RECOVERY VARCHAR2(240)
  RECYCLE := 'RECYCLE' ; -- RECYCLE VARCHAR2(240)
  RECYCLEBIN := 'RECYCLEBIN' ; -- RECYCLEBIN VARCHAR2(240)
  REDUCED := 'REDUCED' ; -- REDUCED VARCHAR2(240)
  REDUNDANCY := 'REDUNDANCY' ; -- REDUNDANCY VARCHAR2(240)
  REF := 'REF' ; -- REF VARCHAR2(240)
  REF_CASCADE_CURSOR := 'REF_CASCADE_CURSOR' ; -- REF_CASCADE_CURSOR VARCHAR2(240)
  REFERENCE := 'REFERENCE' ; -- REFERENCE VARCHAR2(240)
  REFERENCED := 'REFERENCED' ; -- REFERENCED VARCHAR2(240)
  REFERENCES := 'REFERENCES' ; -- REFERENCES VARCHAR2(240)
  --REFERENCING := '--REFERENCING' ; -- --REFERENCING VARCHAR2(240)
  REFRESH := 'REFRESH' ; -- REFRESH VARCHAR2(240)
  REGEXP_LIKE := 'REGEXP_LIKE' ; -- REGEXP_LIKE VARCHAR2(240)
  REGISTER := 'REGISTER' ; -- REGISTER VARCHAR2(240)
  REJECT := 'REJECT' ; -- REJECT VARCHAR2(240)
  REKEY := 'REKEY' ; -- REKEY VARCHAR2(240)
  RELATIONAL := 'RELATIONAL' ; -- RELATIONAL VARCHAR2(240)
  RELY := 'RELY' ; -- RELY VARCHAR2(240)
  REMOTE_MAPPED := 'REMOTE_MAPPED' ; -- REMOTE_MAPPED VARCHAR2(240)
  REPAIR := 'REPAIR' ; -- REPAIR VARCHAR2(240)
  REPLACE := 'REPLACE' ; -- REPLACE VARCHAR2(240)
  REQUIRED := 'REQUIRED' ; -- REQUIRED VARCHAR2(240)
  RESET := 'RESET' ; -- RESET VARCHAR2(240)
  RESETLOGS := 'RESETLOGS' ; -- RESETLOGS VARCHAR2(240)
  RESIZE := 'RESIZE' ; -- RESIZE VARCHAR2(240)
  RESOLVE := 'RESOLVE' ; -- RESOLVE VARCHAR2(240)
  RESOLVER := 'RESOLVER' ; -- RESOLVER VARCHAR2(240)
  RESTORE := 'RESTORE' ; -- RESTORE VARCHAR2(240)
  RESTORE_AS_INTERVALS := 'RESTORE_AS_INTERVALS' ; -- RESTORE_AS_INTERVALS VARCHAR2(240)
  RESTRICT := 'RESTRICT' ; -- RESTRICT VARCHAR2(240)
  RESTRICT_ALL_REF_CONS := 'RESTRICT_ALL_REF_CONS' ; -- RESTRICT_ALL_REF_CONS VARCHAR2(240)
  RESTRICTED := 'RESTRICTED' ; -- RESTRICTED VARCHAR2(240)
  RESUMABLE := 'RESUMABLE' ; -- RESUMABLE VARCHAR2(240)
  RESUME := 'RESUME' ; -- RESUME VARCHAR2(240)
  RETENTION := 'RETENTION' ; -- RETENTION VARCHAR2(240)
  RESULT := 'RESULT' ; -- RESULT VARCHAR2(240)
  --SRT 20110508 RETURN := 'RETURN' ; -- RETURN VARCHAR2(240)
  RETURNING := 'RETURNING' ; -- RETURNING VARCHAR2(240)
  REUSE := 'REUSE' ; -- REUSE VARCHAR2(240)
  --SRT 20110508 REVERSE := 'REVERSE' ; -- REVERSE VARCHAR2(240)
  REWRITE := 'REWRITE' ; -- REWRITE VARCHAR2(240)
  REWRITE_OR_ERROR := 'REWRITE_OR_ERROR' ; -- REWRITE_OR_ERROR VARCHAR2(240)
  RIGHT := 'RIGHT' ; -- RIGHT VARCHAR2(240)
  ROLE := 'ROLE' ; -- ROLE VARCHAR2(240)
  ROLES := 'ROLES' ; -- ROLES VARCHAR2(240)
  --SRT 20120430  ROLLBACK := 'ROLLBACK' ; -- ROLLBACK VARCHAR2(240)
  ROLLING := 'ROLLING' ; -- ROLLING VARCHAR2(240)
  ROLLUP := 'ROLLUP' ; -- ROLLUP VARCHAR2(240)
  ROW := 'ROW' ; -- ROW VARCHAR2(240)
  ROW_LENGTH := 'ROW_LENGTH' ; -- ROW_LENGTH VARCHAR2(240)
  ROWDEPENDENCIES := 'ROWDEPENDENCIES' ; -- ROWDEPENDENCIES VARCHAR2(240)
  --SRT 20110508 ROWID := 'ROWID' ; -- ROWID VARCHAR2(240)
  --SRT 20110508 ROWNUM := 'ROWNUM' ; -- ROWNUM VARCHAR2(240)
  ROWS := 'ROWS' ; -- ROWS VARCHAR2(240)
  RULE := 'RULE' ; -- RULE VARCHAR2(240)
  RULES := 'RULES' ; -- RULES VARCHAR2(240)
  SALT := 'SALT' ; -- SALT VARCHAR2(240)
  SAMPLE := 'SAMPLE' ; -- SAMPLE VARCHAR2(240)
  SAVE_AS_INTERVALS := 'SAVE_AS_INTERVALS' ; -- SAVE_AS_INTERVALS VARCHAR2(240)
  --SRT 20120430  SAVEPOINT := 'SAVEPOINT' ; -- SAVEPOINT VARCHAR2(240)
  SB4 := 'SB4' ; -- SB4 VARCHAR2(240)
  SCALE := 'SCALE' ; -- SCALE VARCHAR2(240)
  SCALE_ROWS := 'SCALE_ROWS' ; -- SCALE_ROWS VARCHAR2(240)
  SCAN := 'SCAN' ; -- SCAN VARCHAR2(240)
  SCAN_INSTANCES := 'SCAN_INSTANCES' ; -- SCAN_INSTANCES VARCHAR2(240)
  SCHEDULER := 'SCHEDULER' ; -- SCHEDULER VARCHAR2(240)
  SCHEMA := 'SCHEMA' ; -- SCHEMA VARCHAR2(240)
  SCN := 'SCN' ; -- SCN VARCHAR2(240)
  SCN_ASCENDING := 'SCN_ASCENDING' ; -- SCN_ASCENDING VARCHAR2(240)
  SCOPE := 'SCOPE' ; -- SCOPE VARCHAR2(240)
  SD_ALL := 'SD_ALL' ; -- SD_ALL VARCHAR2(240)
  SD_INHIBIT := 'SD_INHIBIT' ; -- SD_INHIBIT VARCHAR2(240)
  SD_SHOW := 'SD_SHOW' ; -- SD_SHOW VARCHAR2(240)
  SECOND := 'SECOND' ; -- SECOND VARCHAR2(240)
  SECURITY := 'SECURITY' ; -- SECURITY VARCHAR2(240)
  SEED := 'SEED' ; -- SEED VARCHAR2(240)
  SEG_BLOCK := 'SEG_BLOCK' ; -- SEG_BLOCK VARCHAR2(240)
  SEG_FILE := 'SEG_FILE' ; -- SEG_FILE VARCHAR2(240)
  SEGMENT := 'SEGMENT' ; -- SEGMENT VARCHAR2(240)
  SELECTIVITY := 'SELECTIVITY' ; -- SELECTIVITY VARCHAR2(240)
  SEMIJOIN := 'SEMIJOIN' ; -- SEMIJOIN VARCHAR2(240)
  SEMIJOIN_DRIVER := 'SEMIJOIN_DRIVER' ; -- SEMIJOIN_DRIVER VARCHAR2(240)
  SEQUENCE := 'SEQUENCE' ; -- SEQUENCE VARCHAR2(240)
  SEQUENCED := 'SEQUENCED' ; -- SEQUENCED VARCHAR2(240)
  SEQUENTIAL := 'SEQUENTIAL' ; -- SEQUENTIAL VARCHAR2(240)
  SERIALIZABLE := 'SERIALIZABLE' ; -- SERIALIZABLE VARCHAR2(240)
  SERVERERROR := 'SERVERERROR' ; -- SERVERERROR VARCHAR2(240)
  SESSION := 'SESSION' ; -- SESSION VARCHAR2(240)
  SESSION_CACHED_CURSORS := 'SESSION_CACHED_CURSORS' ; -- SESSION_CACHED_CURSORS VARCHAR2(240)
  SESSIONS_PER_USER := 'SESSIONS_PER_USER' ; -- SESSIONS_PER_USER VARCHAR2(240)
  SESSIONTIMEZONE := 'SESSIONTIMEZONE' ; -- SESSIONTIMEZONE VARCHAR2(240)
  SESSIONTZNAME := 'SESSIONTZNAME' ; -- SESSIONTZNAME VARCHAR2(240)
  SET_TO_JOIN := 'SET_TO_JOIN' ; -- SET_TO_JOIN VARCHAR2(240)
  SETS := 'SETS' ; -- SETS VARCHAR2(240)
  SETTINGS := 'SETTINGS' ; -- SETTINGS VARCHAR2(240)
  SEVERE := 'SEVERE' ; -- SEVERE VARCHAR2(240)
  SHARED := 'SHARED' ; -- SHARED VARCHAR2(240)
  SHARED_POOL := 'SHARED_POOL' ; -- SHARED_POOL VARCHAR2(240)
  SHRINK := 'SHRINK' ; -- SHRINK VARCHAR2(240)
  SHUTDOWN := 'SHUTDOWN' ; -- SHUTDOWN VARCHAR2(240)
  SIBLINGS := 'SIBLINGS' ; -- SIBLINGS VARCHAR2(240)
  SID := 'SID' ; -- SID VARCHAR2(240)
  SIMPLE := 'SIMPLE' ; -- SIMPLE VARCHAR2(240)
  SINGLE := 'SINGLE' ; -- SINGLE VARCHAR2(240)
  SINGLETASK := 'SINGLETASK' ; -- SINGLETASK VARCHAR2(240)
  SKIP := 'SKIP' ; -- SKIP VARCHAR2(240)
  SKIP_EXT_OPTIMIZER := 'SKIP_EXT_OPTIMIZER' ; -- SKIP_EXT_OPTIMIZER VARCHAR2(240)
  SKIP_UNQ_UNUSABLE_IDX := 'SKIP_UNQ_UNUSABLE_IDX' ; -- SKIP_UNQ_UNUSABLE_IDX VARCHAR2(240)
  SKIP_UNUSABLE_INDEXES := 'SKIP_UNUSABLE_INDEXES' ; -- SKIP_UNUSABLE_INDEXES VARCHAR2(240)
  SMALLFILE := 'SMALLFILE' ; -- SMALLFILE VARCHAR2(240)
  SNAPSHOT := 'SNAPSHOT' ; -- SNAPSHOT VARCHAR2(240)
  SOME := 'SOME' ; -- SOME VARCHAR2(240)
  SORT := 'SORT' ; -- SORT VARCHAR2(240)
  SOURCE := 'SOURCE' ; -- SOURCE VARCHAR2(240)
  SPACE := 'SPACE' ; -- SPACE VARCHAR2(240)
  SPECIFICATION := 'SPECIFICATION' ; -- SPECIFICATION VARCHAR2(240)
  SPFILE := 'SPFILE' ; -- SPFILE VARCHAR2(240)
  SPLIT := 'SPLIT' ; -- SPLIT VARCHAR2(240)
  SPREADSHEET := 'SPREADSHEET' ; -- SPREADSHEET VARCHAR2(240)
  --SRT 20120430  SQL := 'SQL' ; -- SQL VARCHAR2(240)
  SQL_TRACE := 'SQL_TRACE' ; -- SQL_TRACE VARCHAR2(240)
  SQLLDR := 'SQLLDR' ; -- SQLLDR VARCHAR2(240)
  STANDALONE := 'STANDALONE' ; -- STANDALONE VARCHAR2(240)
  STANDBY := 'STANDBY' ; -- STANDBY VARCHAR2(240)
  STAR := 'STAR' ; -- STAR VARCHAR2(240)
  STAR_TRANSFORMATION := 'STAR_TRANSFORMATION' ; -- STAR_TRANSFORMATION VARCHAR2(240)
  STARTUP := 'STARTUP' ; -- STARTUP VARCHAR2(240)
  STATEMENT_ID := 'STATEMENT_ID' ; -- STATEMENT_ID VARCHAR2(240)
  STATIC := 'STATIC' ; -- STATIC VARCHAR2(240)
  STATISTICS := 'STATISTICS' ; -- STATISTICS VARCHAR2(240)
  STOP := 'STOP' ; -- STOP VARCHAR2(240)
  STORAGE := 'STORAGE' ; -- STORAGE VARCHAR2(240)
  STORE := 'STORE' ; -- STORE VARCHAR2(240)
  STREAMS := 'STREAMS' ; -- STREAMS VARCHAR2(240)
  STRICT := 'STRICT' ; -- STRICT VARCHAR2(240)
  STRING := 'STRING' ; -- STRING VARCHAR2(240)
  STRIP := 'STRIP' ; -- STRIP VARCHAR2(240)
  STRUCTURE := 'STRUCTURE' ; -- STRUCTURE VARCHAR2(240)
  SUBMULTISET := 'SUBMULTISET' ; -- SUBMULTISET VARCHAR2(240)
  SUBPARTITION := 'SUBPARTITION' ; -- SUBPARTITION VARCHAR2(240)
  SUBPARTITION_REL := 'SUBPARTITION_REL' ; -- SUBPARTITION_REL VARCHAR2(240)
  SUBPARTITIONS := 'SUBPARTITIONS' ; -- SUBPARTITIONS VARCHAR2(240)
  SUBQUERIES := 'SUBQUERIES' ; -- SUBQUERIES VARCHAR2(240)
  SUBSTITUTABLE := 'SUBSTITUTABLE' ; -- SUBSTITUTABLE VARCHAR2(240)
  --SRT 20110508 SUCCESSFUL := 'SUCCESSFUL' ; -- SUCCESSFUL VARCHAR2(240)
  SUMMARY := 'SUMMARY' ; -- SUMMARY VARCHAR2(240)
  SUPPLEMENTAL := 'SUPPLEMENTAL' ; -- SUPPLEMENTAL VARCHAR2(240)
  SUSPEND := 'SUSPEND' ; -- SUSPEND VARCHAR2(240)
  SWAP_JOIN_INPUTS := 'SWAP_JOIN_INPUTS' ; -- SWAP_JOIN_INPUTS VARCHAR2(240)
  SWITCH := 'SWITCH' ; -- SWITCH VARCHAR2(240)
  SWITCHOVER := 'SWITCHOVER' ; -- SWITCHOVER VARCHAR2(240)
  SYS_DL_CURSOR := 'SYS_DL_CURSOR' ; -- SYS_DL_CURSOR VARCHAR2(240)
  SYS_FBT_INSDEL := 'SYS_FBT_INSDEL' ; -- SYS_FBT_INSDEL VARCHAR2(240)
  SYS_OP_BITVEC := 'SYS_OP_BITVEC' ; -- SYS_OP_BITVEC VARCHAR2(240)
  SYS_OP_CAST := 'SYS_OP_CAST' ; -- SYS_OP_CAST VARCHAR2(240)
  SYS_OP_ENFORCE_NOT_NULL$ := 'SYS_OP_ENFORCE_NOT_NULL$' ; -- SYS_OP_ENFORCE_NOT_NULL$ VARCHAR2(240)
  SYS_OP_EXTRACT := 'SYS_OP_EXTRACT' ; -- SYS_OP_EXTRACT VARCHAR2(240)
  SYS_OP_NOEXPAND := 'SYS_OP_NOEXPAND' ; -- SYS_OP_NOEXPAND VARCHAR2(240)
  SYS_OP_NTCIMG$ := 'SYS_OP_NTCIMG$' ; -- SYS_OP_NTCIMG$ VARCHAR2(240)
  SYS_PARALLEL_TXN := 'SYS_PARALLEL_TXN' ; -- SYS_PARALLEL_TXN VARCHAR2(240)
  SYS_RID_ORDER := 'SYS_RID_ORDER' ; -- SYS_RID_ORDER VARCHAR2(240)
  SYSAUX := 'SYSAUX' ; -- SYSAUX VARCHAR2(240)
  SYSDATE := 'SYSDATE' ; -- SYSDATE VARCHAR2(240)
  SYSDBA := 'SYSDBA' ; -- SYSDBA VARCHAR2(240)
  SYSOPER := 'SYSOPER' ; -- SYSOPER VARCHAR2(240)
  SYSTEM := 'SYSTEM' ; -- SYSTEM VARCHAR2(240)
  SYSTIMESTAMP := 'SYSTIMESTAMP' ; -- SYSTIMESTAMP VARCHAR2(240)
  T := 'T' ; -- T VARCHAR2(240)
  TABLE_STATS := 'TABLE_STATS' ; -- TABLE_STATS VARCHAR2(240)
  TABLES := 'TABLES' ; -- TABLES VARCHAR2(240)
  TABLESPACE := 'TABLESPACE' ; -- TABLESPACE VARCHAR2(240)
  TABLESPACE_NO := 'TABLESPACE_NO' ; -- TABLESPACE_NO VARCHAR2(240)
  TABNO := 'TABNO' ; -- TABNO VARCHAR2(240)
  TEMP_TABLE := 'TEMP_TABLE' ; -- TEMP_TABLE VARCHAR2(240)
  TEMPFILE := 'TEMPFILE' ; -- TEMPFILE VARCHAR2(240)
  TEMPLATE := 'TEMPLATE' ; -- TEMPLATE VARCHAR2(240)
  TEMPORARY := 'TEMPORARY' ; -- TEMPORARY VARCHAR2(240)
  TEST := 'TEST' ; -- TEST VARCHAR2(240)
  THAN := 'THAN' ; -- THAN VARCHAR2(240)
  THE := 'THE' ; -- THE VARCHAR2(240)
  THREAD := 'THREAD' ; -- THREAD VARCHAR2(240)
  THROUGH := 'THROUGH' ; -- THROUGH VARCHAR2(240)
  TIME := 'TIME' ; -- TIME VARCHAR2(240)
  TIME_ZONE := 'TIME_ZONE' ; -- TIME_ZONE VARCHAR2(240)
  TIMEOUT := 'TIMEOUT' ; -- TIMEOUT VARCHAR2(240)
  --SRT 20110508 TIMESTAMP := 'TIMESTAMP' ; -- TIMESTAMP VARCHAR2(240)
  TIMEZONE_ABBR := 'TIMEZONE_ABBR' ; -- TIMEZONE_ABBR VARCHAR2(240)
  TIMEZONE_HOUR := 'TIMEZONE_HOUR' ; -- TIMEZONE_HOUR VARCHAR2(240)
  TIMEZONE_MINUTE := 'TIMEZONE_MINUTE' ; -- TIMEZONE_MINUTE VARCHAR2(240)
  TIMEZONE_OFFSET := 'TIMEZONE_OFFSET' ; -- TIMEZONE_OFFSET VARCHAR2(240)
  TIMEZONE_REGION := 'TIMEZONE_REGION' ; -- TIMEZONE_REGION VARCHAR2(240)
  TIV_GB := 'TIV_GB' ; -- TIV_GB VARCHAR2(240)
  TIV_SSF := 'TIV_SSF' ; -- TIV_SSF VARCHAR2(240)
  TO_CHAR := 'TO_CHAR' ; -- TO_CHAR VARCHAR2(240)
  TOPLEVEL := 'TOPLEVEL' ; -- TOPLEVEL VARCHAR2(240)
  TRACE := 'TRACE' ; -- TRACE VARCHAR2(240)
  TRACING := 'TRACING' ; -- TRACING VARCHAR2(240)
  TRACKING := 'TRACKING' ; -- TRACKING VARCHAR2(240)
  TRAILING := 'TRAILING' ; -- TRAILING VARCHAR2(240)
  TRANSACTION := 'TRANSACTION' ; -- TRANSACTION VARCHAR2(240)
  TRANSITIONAL := 'TRANSITIONAL' ; -- TRANSITIONAL VARCHAR2(240)
  TREAT := 'TREAT' ; -- TREAT VARCHAR2(240)
  TRIGGERS := 'TRIGGERS' ; -- TRIGGERS VARCHAR2(240)
  TRUNCATE := 'TRUNCATE' ; -- TRUNCATE VARCHAR2(240)
  TRUSTED := 'TRUSTED' ; -- TRUSTED VARCHAR2(240)
  TUNING := 'TUNING' ; -- TUNING VARCHAR2(240)
  TX := 'TX' ; -- TX VARCHAR2(240)
  TYPE := 'TYPE' ; -- TYPE VARCHAR2(240)
  TYPES := 'TYPES' ; -- TYPES VARCHAR2(240)
  TZ_OFFSET := 'TZ_OFFSET' ; -- TZ_OFFSET VARCHAR2(240)
  U := 'U' ; -- U VARCHAR2(240)
  UB2 := 'UB2' ; -- UB2 VARCHAR2(240)
  UBA := 'UBA' ; -- UBA VARCHAR2(240)
  UID := 'UID' ; -- UID VARCHAR2(240)
  UNARCHIVED := 'UNARCHIVED' ; -- UNARCHIVED VARCHAR2(240)
  UNBOUND := 'UNBOUND' ; -- UNBOUND VARCHAR2(240)
  UNBOUNDED := 'UNBOUNDED' ; -- UNBOUNDED VARCHAR2(240)
  UNDER := 'UNDER' ; -- UNDER VARCHAR2(240)
  UNDO := 'UNDO' ; -- UNDO VARCHAR2(240)
  UNDROP := 'UNDROP' ; -- UNDROP VARCHAR2(240)
  UNIFORM := 'UNIFORM' ; -- UNIFORM VARCHAR2(240)
  UNLIMITED := 'UNLIMITED' ; -- UNLIMITED VARCHAR2(240)
  UNLOCK := 'UNLOCK' ; -- UNLOCK VARCHAR2(240)
  UNNEST := 'UNNEST' ; -- UNNEST VARCHAR2(240)
  UNPACKED := 'UNPACKED' ; -- UNPACKED VARCHAR2(240)
  UNPROTECTED := 'UNPROTECTED' ; -- UNPROTECTED VARCHAR2(240)
  UNQUIESCE := 'UNQUIESCE' ; -- UNQUIESCE VARCHAR2(240)
  UNRECOVERABLE := 'UNRECOVERABLE' ; -- UNRECOVERABLE VARCHAR2(240)
  UNTIL := 'UNTIL' ; -- UNTIL VARCHAR2(240)
  UNUSABLE := 'UNUSABLE' ; -- UNUSABLE VARCHAR2(240)
  UNUSED := 'UNUSED' ; -- UNUSED VARCHAR2(240)
  UPD_INDEXES := 'UPD_INDEXES' ; -- UPD_INDEXES VARCHAR2(240)
  UPD_JOININDEX := 'UPD_JOININDEX' ; -- UPD_JOININDEX VARCHAR2(240)
  UPDATABLE := 'UPDATABLE' ; -- UPDATABLE VARCHAR2(240)
  UPDATED := 'UPDATED' ; -- UPDATED VARCHAR2(240)
  UPGRADE := 'UPGRADE' ; -- UPGRADE VARCHAR2(240)
  UPSERT := 'UPSERT' ; -- UPSERT VARCHAR2(240)
  UROWID := 'UROWID' ; -- UROWID VARCHAR2(240)
  USAGE := 'USAGE' ; -- USAGE VARCHAR2(240)
  USE := 'USE' ; -- USE VARCHAR2(240)
  USE_ANTI := 'USE_ANTI' ; -- USE_ANTI VARCHAR2(240)
  USE_CONCAT := 'USE_CONCAT' ; -- USE_CONCAT VARCHAR2(240)
  USE_HASH := 'USE_HASH' ; -- USE_HASH VARCHAR2(240)
  USE_HASH_AGGREGATION := 'USE_HASH_AGGREGATION' ; -- USE_HASH_AGGREGATION VARCHAR2(240)
  USE_MERGE := 'USE_MERGE' ; -- USE_MERGE VARCHAR2(240)
  USE_NL := 'USE_NL' ; -- USE_NL VARCHAR2(240)
  USE_NL_WITH_INDEX := 'USE_NL_WITH_INDEX' ; -- USE_NL_WITH_INDEX VARCHAR2(240)
  USE_PRIVATE_OUTLINES := 'USE_PRIVATE_OUTLINES' ; -- USE_PRIVATE_OUTLINES VARCHAR2(240)
  USE_SEMI := 'USE_SEMI' ; -- USE_SEMI VARCHAR2(240)
  USE_STORED_OUTLINES := 'USE_STORED_OUTLINES' ; -- USE_STORED_OUTLINES VARCHAR2(240)
  USE_TTT_FOR_GSETS := 'USE_TTT_FOR_GSETS' ; -- USE_TTT_FOR_GSETS VARCHAR2(240)
  USE_WEAK_NAME_RESL := 'USE_WEAK_NAME_RESL' ; -- USE_WEAK_NAME_RESL VARCHAR2(240)
  USER := 'USER' ; -- USER VARCHAR2(240)
  USER_DEFINED := 'USER_DEFINED' ; -- USER_DEFINED VARCHAR2(240)
  USER_RECYCLEBIN := 'USER_RECYCLEBIN' ; -- USER_RECYCLEBIN VARCHAR2(240)
  USERS := 'USERS' ; -- USERS VARCHAR2(240)
  USING := 'USING' ; -- USING VARCHAR2(240)
  VALIDATE := 'VALIDATE' ; -- VALIDATE VARCHAR2(240)
  VALIDATION := 'VALIDATION' ; -- VALIDATION VARCHAR2(240)
  VALUE := 'VALUE' ; -- VALUE VARCHAR2(240)
  VARRAY := 'VARRAY' ; -- VARRAY VARCHAR2(240)
  VARYING := 'VARYING' ; -- VARYING VARCHAR2(240)
  VECTOR_READ := 'VECTOR_READ' ; -- VECTOR_READ VARCHAR2(240)
  VECTOR_READ_TRACE := 'VECTOR_READ_TRACE' ; -- VECTOR_READ_TRACE VARCHAR2(240)
  VERSION := 'VERSION' ; -- VERSION VARCHAR2(240)
  VERSIONS := 'VERSIONS' ; -- VERSIONS VARCHAR2(240)
  WAIT := 'WAIT' ; -- WAIT VARCHAR2(240)
  WALLET := 'WALLET' ; -- WALLET VARCHAR2(240)
  WELLFORMED := 'WELLFORMED' ; -- WELLFORMED VARCHAR2(240)
  --SRT WHEN := 'WHEN' ; WHEN VARCHAR2(240)
  WHENEVER := 'WHENEVER' ; -- WHENEVER VARCHAR2(240)
  WHITESPACE := 'WHITESPACE' ; -- WHITESPACE VARCHAR2(240)
  WITHIN := 'WITHIN' ; -- WITHIN VARCHAR2(240)
  WITHOUT := 'WITHOUT' ; -- WITHOUT VARCHAR2(240)
  WORK := 'WORK' ; -- WORK VARCHAR2(240)
  WRAPPED := 'WRAPPED' ; -- WRAPPED VARCHAR2(240)
  WRITE := 'WRITE' ; -- WRITE VARCHAR2(240)
  X_DYN_PRUNE := 'X_DYN_PRUNE' ; -- X_DYN_PRUNE VARCHAR2(240)
  XID := 'XID' ; -- XID VARCHAR2(240)
  XML_DML_RWT_STMT := 'XML_DML_RWT_STMT' ; -- XML_DML_RWT_STMT VARCHAR2(240)
  XMLATTRIBUTES := 'XMLATTRIBUTES' ; -- XMLATTRIBUTES VARCHAR2(240)
  XMLCOLATTVAL := 'XMLCOLATTVAL' ; -- XMLCOLATTVAL VARCHAR2(240)
  XMLELEMENT := 'XMLELEMENT' ; -- XMLELEMENT VARCHAR2(240)
  XMLFOREST := 'XMLFOREST' ; -- XMLFOREST VARCHAR2(240)
  XMLNAMESPACES := 'XMLNAMESPACES' ; -- XMLNAMESPACES VARCHAR2(240)
  XMLPARSE := 'XMLPARSE' ; -- XMLPARSE VARCHAR2(240)
  XMLPI := 'XMLPI' ; -- XMLPI VARCHAR2(240)
  XMLQUERY := 'XMLQUERY' ; -- XMLQUERY VARCHAR2(240)
  XMLROOT := 'XMLROOT' ; -- XMLROOT VARCHAR2(240)
  XMLSCHEMA := 'XMLSCHEMA' ; -- XMLSCHEMA VARCHAR2(240)
  XMLSERIALIZE := 'XMLSERIALIZE' ; -- XMLSERIALIZE VARCHAR2(240)
  XMLTABLE := 'XMLTABLE' ; -- XMLTABLE VARCHAR2(240)
  XMLTYPE := 'XMLTYPE' ; -- XMLTYPE VARCHAR2(240)
  YEAR := 'YEAR' ; -- YEAR VARCHAR2(240)
  YES := 'YES' ; -- YES VARCHAR2(240)
  ZONE := 'ZONE' ; -- ZONE VARCHAR2(240)
  /*
    Try Assignments to problem variables as quoted variables 
  */
  "ADD" := 'ADD' ; -- ADD VARCHAR2(240)
  "AT" := 'AT' ; -- AT VARCHAR2(240)
  "ATTRIBUTE" := 'ATTRIBUTE' ; -- ATTRIBUTE VARCHAR2(240)
  "AUTHID" := 'AUTHID' ; -- AUTHID VARCHAR2(240)
  "BFILE" := 'BFILE' ; -- BFILE VARCHAR2(240)
  "BLOB" := 'BLOB' ; -- BLOB VARCHAR2(240)
  "BULK" := 'BULK' ; -- BULK VARCHAR2(240)
  "BY" := 'BY' ; -- BY VARCHAR2(240)
  "BYTE" := 'BYTE' ; -- BYTE VARCHAR2(240)
  "CASE" := 'CASE' ; -- CASE VARCHAR2(240)
  "CHARACTER" := 'CHARACTER' ; -- CHARACTER VARCHAR2(240)
  "CLOB" := 'CLOB' ; -- CLOB VARCHAR2(240)
  "CLOSE" := 'CLOSE' ; -- CLOSE VARCHAR2(240)
  "COALESCE" := 'COALESCE' ; -- COALESCE VARCHAR2(240)
  "COLLECT" := 'COLLECT' ; -- COLLECT VARCHAR2(240)
  "COMMENT" := 'COMMENT' ; -- COMMENT VARCHAR2(240)
  "CURRENT" := 'CURRENT' ; -- CURRENT VARCHAR2(240)
  "CURRENT_USER" := 'CURRENT_USER' ; -- CURRENT_USER VARCHAR2(240)
  "CURSOR" := 'CURSOR' ; -- CURSOR VARCHAR2(240)
  "DEC" := 'DEC' ; -- DEC VARCHAR2(240)
  "DECLARE" := 'DECLARE' ; -- DECLARE VARCHAR2(240)
  "DEFINER" := 'DEFINER' ; -- DEFINER VARCHAR2(240)
  "DOUBLE" := 'DOUBLE' ; -- DOUBLE VARCHAR2(240)
  "ELEMENT" := 'ELEMENT' ; -- ELEMENT VARCHAR2(240)
  "EXTENDS" := 'EXTENDS' ; -- EXTENDS VARCHAR2(240)
  "EXTERNAL" := 'EXTERNAL' ; -- EXTERNAL VARCHAR2(240)
  "FINAL" := 'FINAL' ; -- FINAL VARCHAR2(240)
  "HEAP" := 'HEAP' ; -- HEAP VARCHAR2(240)
  "IF" := 'IF' ; -- IF VARCHAR2(240)
  "IMMEDIATE" := 'IMMEDIATE' ; -- IMMEDIATE VARCHAR2(240)
  "INDICATOR" := 'INDICATOR' ; -- INDICATOR VARCHAR2(240)
  "INSTANTIABLE" := 'INSTANTIABLE' ; -- INSTANTIABLE VARCHAR2(240)
  "INTERVAL" := 'INTERVAL' ; -- INTERVAL VARCHAR2(240)
  "ISOLATION" := 'ISOLATION' ; -- ISOLATION VARCHAR2(240)
  "JAVA" := 'JAVA' ; -- JAVA VARCHAR2(240)
  "LEVEL" := 'LEVEL' ; -- LEVEL VARCHAR2(240)
  "LIMIT" := 'LIMIT' ; -- LIMIT VARCHAR2(240)
  "LOCAL" := 'LOCAL' ; -- LOCAL VARCHAR2(240)
  "MAX" := 'MAX' ; -- MAX VARCHAR2(240)
  "MEMBER" := 'MEMBER' ; -- MEMBER VARCHAR2(240)
  "MIN" := 'MIN' ; -- MIN VARCHAR2(240)
  "MLSLABEL" := 'MLSLABEL' ; -- MLSLABEL VARCHAR2(240)
  "MODIFY" := 'MODIFY' ; -- MODIFY VARCHAR2(240)
  "NATURAL" := 'NATURAL' ; -- NATURAL VARCHAR2(240)
  "NCHAR" := 'NCHAR' ; -- NCHAR VARCHAR2(240)
  "NCLOB" := 'NCLOB' ; -- NCLOB VARCHAR2(240)
  "NEW" := 'NEW' ; -- NEW VARCHAR2(240)
  "NUMERIC" := 'NUMERIC' ; -- NUMERIC VARCHAR2(240)
  "NVARCHAR2" := 'NVARCHAR2' ; -- NVARCHAR2 VARCHAR2(240)
  "OBJECT" := 'OBJECT' ; -- OBJECT VARCHAR2(240)
  "OID" := 'OID' ; -- OID VARCHAR2(240)
  "OPAQUE" := 'OPAQUE' ; -- OPAQUE VARCHAR2(240)
  "OPEN" := 'OPEN' ; -- OPEN VARCHAR2(240)
  "ORGANIZATION" := 'ORGANIZATION' ; -- ORGANIZATION VARCHAR2(240)
  "PACKAGE" := 'PACKAGE' ; -- PACKAGE VARCHAR2(240)
  "PARENT" := 'PARENT' ; -- PARENT VARCHAR2(240)
  "PARTITION" := 'PARTITION' ; -- PARTITION VARCHAR2(240)
  "PRECISION" := 'PRECISION' ; -- PRECISION VARCHAR2(240)
  "RANGE" := 'RANGE' ; -- RANGE VARCHAR2(240)
  "REAL" := 'REAL' ; -- REAL VARCHAR2(240)
  "REF" := 'REF' ; -- REF VARCHAR2(240)
  "RETURN" := 'RETURN' ; -- RETURN VARCHAR2(240)
  "REVERSE" := 'REVERSE' ; -- REVERSE VARCHAR2(240)
  "ROWID" := 'ROWID' ; -- ROWID VARCHAR2(240)
  "ROWNUM" := 'ROWNUM' ; -- ROWNUM VARCHAR2(240)
  "SPACE" := 'SPACE' ; -- SPACE VARCHAR2(240)
  "STATIC" := 'STATIC' ; -- STATIC VARCHAR2(240)
  "SUCCESSFUL" := 'SUCCESSFUL' ; -- SUCCESSFUL VARCHAR2(240)
  "TIME" := 'TIME' ; -- TIME VARCHAR2(240)
  "TIMESTAMP" := 'TIMESTAMP' ; -- TIMESTAMP VARCHAR2(240)
  "TIMEZONE_ABBR" := 'TIMEZONE_ABBR' ; -- TIMEZONE_ABBR VARCHAR2(240)
  "TIMEZONE_HOUR" := 'TIMEZONE_HOUR' ; -- TIMEZONE_HOUR VARCHAR2(240)
  "TIMEZONE_MINUTE" := 'TIMEZONE_MINUTE' ; -- TIMEZONE_MINUTE VARCHAR2(240)
  "TIMEZONE_REGION" := 'TIMEZONE_REGION' ; -- TIMEZONE_REGION VARCHAR2(240)
  "UNDER" := 'UNDER' ; -- UNDER VARCHAR2(240)
  "UROWID" := 'UROWID' ; -- UROWID VARCHAR2(240)
  "VARRAY" := 'VARRAY' ; -- VARRAY VARCHAR2(240)
  "VARYING" := 'VARYING' ; -- VARYING VARCHAR2(240)
  "ZONE" := 'ZONE' ; -- ZONE VARCHAR2(240)

 -- Try using reserved words as columns in a cursor query and record 
  FOR rec_reserved_words IN 
  (
  SELECT 
   'AT' AT 
  ,'BEGIN' BEGIN 
  ,'BY' "BY" 
  ,'CASE' CASE 
  ,'CLOSE' CLOSE 
  ,'COLLECT' COLLECT 
  ,'COLUMNS' COLUMNS 
  ,'COMMIT' COMMIT 
  ,'CURRENT' "CURRENT" 
  ,'DEC' DEC 
  ,'DECLARE' DECLARE 
  ,'DEFINER' DEFINER 
  ,'DOUBLE' DOUBLE 
  ,'END' END 
  ,'EXTENDS' EXTENDS 
  ,'FUNCTION' FUNCTION 
  ,'HEAP' HEAP 
  ,'IF' IF 
  ,'IMMEDIATE' IMMEDIATE 
  ,'INDEXES' INDEXES 
  ,'INDICATOR' INDICATOR 
  ,'INTERVAL' INTERVAL 
  ,'ISOLATION' ISOLATION 
  ,'JAVA' JAVA 
  ,'LEVEL' LEVEL 
  ,'MAX' MAX 
  ,'MIN' MIN 
  ,'MLSLABEL' MLSLABEL 
  ,'NATURAL' NATURAL 
  ,'NUMERIC' NUMERIC 
  ,'OPAQUE' OPAQUE 
  ,'OPEN' OPEN 
  ,'ORGANIZATION' ORGANIZATION 
  ,'OVERLAPS' OVERLAPS 
  ,'PACKAGE' PACKAGE 
  ,'PRECISION' PRECISION 
  ,'PROCEDURE' PROCEDURE  
  ,'REAL' REAL 
  ,'RETURN' RETURN 
  ,'REVERSE' REVERSE 
  ,'ROLLBACK' ROLLBACK 
  ,'ROWID' ROWID 
  ,'ROWNUM' ROWNUM 
  ,'SAVEPOINT' SAVEPOINT 
  ,'SQL' SQL 
  ,'SUCCESSFUL' SUCCESSFUL 
  ,'TIMESTAMP' TIMESTAMP 
  ,'WHEN' WHEN 
  FROM dual
  )
  LOOP
	  DBMS_OUTPUT.PUT_LINE(
	   'AT==' || rec_reserved_words."AT"
	  ||',BEGIN==' || rec_reserved_words."BEGIN"
	  ||',BY==' || rec_reserved_words."BY"
	  ||',CASE==' || rec_reserved_words."CASE"
	  ||',CLOSE==' || rec_reserved_words.CLOSE
	  ||',COLLECT==' || rec_reserved_words.COLLECT
	  ||',COLUMNS==' || rec_reserved_words."COLUMNS"
	  ||',COMMIT==' || rec_reserved_words.COMMIT
	  ||',CURRENT==' || rec_reserved_words.CURRENT
	  ||',DEC==' || rec_reserved_words.DEC
	  ||',DECLARE==' || rec_reserved_words."DECLARE"
	  ||',DEFINER==' || rec_reserved_words.DEFINER
	  ||',DOUBLE==' || rec_reserved_words.DOUBLE
	  ||',END==' || rec_reserved_words."END"
	  ||',EXTENDS==' || rec_reserved_words.EXTENDS
	  ||',FUNCTION==' || rec_reserved_words.FUNCTION
	  ||',HEAP==' || rec_reserved_words.HEAP
	  ||',IF==' || rec_reserved_words."IF"
	  ||',IMMEDIATE==' || rec_reserved_words.IMMEDIATE
	  ||',INDEXES==' || rec_reserved_words."INDEXES"
	  ||',INDICATOR==' || rec_reserved_words.INDICATOR
	  ||',INTERVAL==' || rec_reserved_words.INTERVAL
	  ||',ISOLATION==' || rec_reserved_words.ISOLATION
	  ||',JAVA==' || rec_reserved_words.JAVA
	  ||',LEVEL==' || rec_reserved_words.LEVEL
	  ||',MAX==' || rec_reserved_words.MAX
	  ||',MIN==' || rec_reserved_words.MIN
	  ||',MLSLABEL==' || rec_reserved_words.MLSLABEL
	  ||',NATURAL==' || rec_reserved_words.NATURAL
	  ||',NUMERIC==' || rec_reserved_words.NUMERIC
	  ||',OPAQUE==' || rec_reserved_words.OPAQUE
	  ||',OPEN==' || rec_reserved_words.OPEN
	  ||',ORGANIZATION==' || rec_reserved_words.ORGANIZATION
	  ||',OVERLAPS==' || rec_reserved_words."OVERLAPS"
	  ||',PACKAGE==' || rec_reserved_words.PACKAGE
	  ||',PRECISION==' || rec_reserved_words.PRECISION
	  ||',PROCEDURE==' || rec_reserved_words."PROCEDURE"
	  ||',REAL==' || rec_reserved_words.REAL
	  ||',RETURN==' || rec_reserved_words.RETURN
	  ||',REVERSE==' || rec_reserved_words.REVERSE
	  ||',ROLLBACK==' || rec_reserved_words.ROLLBACK
	  ||',ROWID==' || rec_reserved_words.ROWID
	  ||',ROWNUM==' || rec_reserved_words.ROWNUM
	  ||',SAVEPOINT==' || rec_reserved_words.SAVEPOINT
	  ||',SQL==' || rec_reserved_words."SQL"
	  ||',SUCCESSFUL==' || rec_reserved_words.SUCCESSFUL
	  ||',TIMESTAMP==' || rec_reserved_words.TIMESTAMP
	  ||',WHEN==' || rec_reserved_words."WHEN"
	  );
  END LOOP;



 RETURN 'FINISHED'; 
END fnc_test_unreserved_keyword;
/
   
SHOW ERRORS
