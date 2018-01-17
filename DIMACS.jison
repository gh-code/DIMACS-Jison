/* description: DIMACS parser */
/* author: Gary Huang <gh.nctu+code@gmail.com> */

/* lexical grammar */
%lex

lineEnd (\n\r|\r\n|[\n\r])
%s comment

%%

<comment>(?={lineEnd})  
        %{
                this.popState();
                /* return 'COMMENT_END'; */
        %}
<comment>(?=<<EOF>>)
        %{
                this.popState();
                /* return 'COMMENT_END'; */
        %}
<comment>(.)
        %{
                /* return 'COMMENT_BODY'; */
        %}
"c"
        %{
                this.begin('comment');
                /* return 'COMMENT_BEGIN'; */
        %}
"-"[1-9][0-9]*  return 'NEGATE_LITERAL'
[1-9][0-9]*     return 'NUMBER'
"p"             return 'P'
"cnf"           return 'FORMAT'
"0"             return 'EOL'
\s+             /* skip whitespace */
{lineEnd}       /* skip lines*/
<<EOF>>         return 'EOF'
.               return 'INVALID'

/lex

%start document

%%

document
    : problem clause_list EOF
        { $1.clauses = $2; return $1; }
    | clause_list EOF
        { return {clauses: $1}; }
    ;

problem
    : P FORMAT NUMBER NUMBER
        { $$ = {format: $2, num_variables: parseInt($3), num_clauses: parseInt($4)}; }
    ;

clause_list
    : clause
        { $$ = [$1]; }
    | clause_list clause
        { $$.push($2); }
    ;

clause
    : literal_list EOL
        { $$ = $1; }
    ;

literal_list
    : literal
        { $$ = [$1]; }
    | literal_list literal
        { $$.push($2); }
    ;

literal
    : NUMBER
        { $$ = parseInt($1); }
    | NEGATE_LITERAL
        { $$ = parseInt($1); }
    ;
