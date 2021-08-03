#ifndef _LOWLEVEL_H
#define _LOWLEVEL_H 1

/*
* func port_byte_in
* @brief : Recieves data from @port
* @return : Byte recieved from @port
*/
unsigned char port_byte_in(unsigned short port);

/*
* func port_byte_out
* @brief : Sends @data to the @port
*/
void port_byte_out(unsigned short port,unsigned char data);

/*
* func port_word_in
* @brief : Recieves data from @port
* @return : Word recieved from @port
*/
unsigned short port_word_in(unsigned short port);

/*
* func port_word_out
* @brief : Sends @data to the @port
*/
void port_word_out(unsigned short port, unsigned short data);


#endif