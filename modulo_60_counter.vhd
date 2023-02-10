-------------------------------------------------------------------------------
--
-- Title       : modulo_60_counter
-- Design      : Modulo_60_Counter
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab10\Design Task 4\Modulo_60_Counter\Modulo_60_Counter\src\modulo_60_counter.vhd
-- Generated   : Sat Apr 17 00:44:44 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for a modulo 60 counter. It
--				 takes in a count enable, and then begins counting for every
--				 pos clk edge cnt_en_1 is assrted. It also parallel loads in
--				 data to the output. 
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulo_60_counter is
	port(
		rst_n : in std_logic;				-- active low synchronous reset
		clk : in std_logic;					-- system clock
		clr_n : in std_logic;				-- active low synchronous clear
		load_en : in std_logic;				-- parallel load active high
		setting : in std_logic_vector(6 downto 0);	-- load value 
		cnt_en_1 : in std_logic;					-- enable count 1
		cnt_en_2 : in std_logic;					-- enable count 2
		max_count : out std_logic;					-- maximum count flag
		count : out std_logic_vector(6 downto 0)	-- BCD count
	);
end modulo_60_counter;

--architecture behavior of modulo_60_counter is
--begin
--	
--	counter: process (clk)
--	variable bcd0: integer := 0;
--	variable bcd1: integer := 0;
--	begin 
--		if rising_edge(clk) then 
--			
--			-- if rst_n is asserted
--			if rst_n = '0' then
--				max_count <= '0';	-- max count reinitialized
--				count <= "0000000";	-- count is set to all 0's
--				bcd0 := 0;
--				bcd1 := 0;
--			
--			-- if clr_n is asserted
--			elsif clr_n = '0' then
--				max_count <= '0';	-- max count reinitialized
--				count <= "0000000";	-- count is set to all 0's
--				bcd0 := 0;
--				bcd1 := 0;
--				
--			-- if load_en is asserted
--			elsif load_en = '1' then
--				count <= setting;	-- parallel load settings out 
--				bcd0 := to_integer(unsigned(setting(3 downto 0)));
--				bcd1 := to_integer(unsigned(setting(6 downto 4)));
--
--			elsif cnt_en_1 = '1' then
--				if (bcd1 = 5) and (bcd0 = 8) then
--					max_count <= '1';
--					bcd1 := 5;
--					bcd0 := 9;	
--					
--				elsif (bcd1 = 5) and (bcd0 = 9) then
--					bcd1 := 0;
--					bcd0 := 0;
--					max_count <= '0';
--					
--				elsif bcd0 < 9 then
--					bcd0 := bcd0 + 1;  
--					max_count <= '0';
--					
--				elsif bcd0 = 9 then
--					if cnt_en_2 = '1' then
--						bcd1 := bcd1 + 1;
--						bcd0 := 0;
--					end if;
--					max_count <= '0';
--					
--				end if;
--
--			end if;	  
--
--		end if;
--		count <= std_logic_vector(to_unsigned(bcd1, 3)) & std_logic_vector(to_unsigned(bcd0, 4));	-- count gets the count
--	end process;
--
--end behavior;



architecture behavior of modulo_60_counter is
begin
	
	counter: process (clk)
	variable bcd0: integer := 0;
	variable bcd1: integer := 0;
	begin 
		if rising_edge(clk) then 
			
			-- if rst_n is asserted
			if rst_n = '0' then
				max_count <= '0';	-- max count reinitialized
				count <= "0000000";	-- count is set to all 0's
				bcd0 := 0;
				bcd1 := 0;
			
			-- if clr_n is asserted
			elsif clr_n = '0' then
				max_count <= '0';	-- max count reinitialized
				count <= "0000000";	-- count is set to all 0's
				bcd0 := 0;
				bcd1 := 0;
				
			-- if load_en is asserted
			elsif load_en = '1' then
				count <= setting;	-- parallel load settings out 
				bcd0 := to_integer(unsigned(setting(3 downto 0)));
				bcd1 := to_integer(unsigned(setting(6 downto 4)));
				
				if bcd1 = 5 and bcd0 = 9 then
					max_count <= '1';
				end if;
				
				
			elsif cnt_en_1 = '1' and cnt_en_2 = '1' then
				if (bcd1 = 5) and (bcd0 = 8) then
					max_count <= '1';
					bcd1 := 5;
					bcd0 := 9;	
					
				elsif (bcd1 = 5) and (bcd0 = 9) then
					bcd1 := 0;
					bcd0 := 0;
					max_count <= '0';
					
				elsif bcd0 < 9 then
					bcd0 := bcd0 + 1;  
					max_count <= '0';
					
				elsif bcd0 = 9 then
				--	if cnt_en_2 = '1' then
						bcd1 := bcd1 + 1;
						bcd0 := 0;
				--	end if;
					max_count <= '0';
					
				end if;

			end if;	  

		end if;
		count <= std_logic_vector(to_unsigned(bcd1, 3)) & std_logic_vector(to_unsigned(bcd0, 4));	-- count gets the count
	end process;

end behavior;