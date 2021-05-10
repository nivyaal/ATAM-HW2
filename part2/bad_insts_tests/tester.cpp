#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <vector>
using namespace std;

int what_to_do(std::string str)
{
 char *p;
  long n =strtoul(str.c_str(),&p,16);
  return n-4;
}

int main ()
{
	std::vector<std::string>  my_vec; // one byte vector
	my_vec.push_back("0x06");
	my_vec.push_back("0x07");
	my_vec.push_back("0x0e");
	my_vec.push_back("0x16");
	my_vec.push_back("0x17");
	my_vec.push_back("0x1e");
	my_vec.push_back("0x1f");
	my_vec.push_back("0x27");
	my_vec.push_back("0x2f");
	my_vec.push_back("0x37");
	my_vec.push_back("0x3f");
	my_vec.push_back("0x60");
	my_vec.push_back("0x61");
	my_vec.push_back("0x62");
	my_vec.push_back("0x82");
	my_vec.push_back("0x9a");
	my_vec.push_back("0xc4");
	my_vec.push_back("0xc5");
	my_vec.push_back("0xd4");
	my_vec.push_back("0xd5");
	my_vec.push_back("0xd6");
	my_vec.push_back("0xea");
	int cnt = 1;
	for( auto it : my_vec)
	{
	ofstream myfile;
	ofstream myfile2;
	myfile.open("bad_inst_"+std::to_string(cnt)+".asm");
	myfile2.open("bad_inst_"+std::to_string(cnt)+".out");
	myfile2 << "start" << std::endl;
	myfile2 << std::to_string(what_to_do(it)) << std::endl;
	myfile << ".global _start" <<std::endl;
	myfile << ".section .data"<<std::endl;
	myfile << "msg1: .ascii \"start\\n\"" <<std::endl;
	myfile <<"endmsg:" <<std::endl;
	myfile <<"\n"<<std::endl;
	myfile <<".section .text"<<std::endl;
	myfile <<"\n"<<std::endl;
	myfile <<"_start:"<<std::endl;
	myfile <<"movq $1, %rax"<<std::endl;
	myfile <<"movq $1, %rdi" <<std::endl;
	myfile << "leaq msg1, %rsi"<<std::endl;
	myfile << "movq $endmsg-msg1, %rdx"<<std::endl;
	myfile <<"syscall"<<std::endl;
	myfile  << ".byte ";
	myfile <<it<<std::endl;
	myfile <<"movq $60,%rax" << std::endl;
	myfile  << "syscall"<<std::endl;
	myfile.close();
	myfile2.close();
	cnt++;
	}



}

/*
.global _start

.section .data
msg1: .ascii "start\n"
endmsg:

.section .text

_start:
  movq $1, %rax
  movq $1, %rdi
  leaq msg1, %rsi
  movq $endmsg-msg1, %rdx
  syscall

  .byte 0x27 #ILLEGAL!!!

  movq $60, %rax
  syscall
*/
