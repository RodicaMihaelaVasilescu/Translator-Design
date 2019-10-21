extern 
  int yyparse();

int main()
{
  int result = yyparse();
  if(result) {
    std::cout << "The input is valid"<< std::endl;
  }
  else {
    std::cout << "The input is invalid"<< std::endl;
  }
  return result;
}
