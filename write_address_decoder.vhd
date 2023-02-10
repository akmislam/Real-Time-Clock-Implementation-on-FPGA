-------------------------------------------------------------------------------
--
-- Title       : write_address_decoder
-- Design      : Task3
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab11\Task 3\Task3\Task3\src\write_address_decoder.vhd
-- Generated   : Sun Apr 25 19:21:50 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for a smaller entity address
--				 decoder. This offers a select signal to the RTC which comes
--				 from a decoded higher order address byte.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity write_address_decoder is
	port(
		wr : in std_logic; 							-- write enable input
		cs_n : in std_logic; 						-- chip select input
		address : in std_logic_vector(3 downto 0); 	-- address bus
		y : out std_logic_vector(9 downto 0)		-- selected high
	);
end write_address_decoder;


architecture behavior of write_address_decoder is
begin 
	RTC_decoder: process (cs_n, wr, address) -- process is sensitive to all
	begin									 -- inputs
		case (cs_n) is
			when '0' =>	  	 -- when cs_n is 0 and wr is 1,
				case (wr) is -- decode the output but rotating bit by address
					when '1' => y <= ("0000000001" rol to_integer(unsigned(address))); 
					when others => y <= "0000000000";
				end case;	 -- otherwise, output gets all 0's.
			when others => y <= "0000000000";
		end case;
	end process;
end behavior;
