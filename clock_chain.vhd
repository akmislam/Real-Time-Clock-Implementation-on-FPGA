-------------------------------------------------------------------------------
--
-- Title       : clock_chain
-- Design      : Task2
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab11\Task 2\Task2\Task2\src\clock_chain.vhd
-- Generated   : Sun Apr 25 16:09:49 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for a clock chain. It
--				 instantiates 2 different design entities (modulo counters)
--				 with some logic blocks to create a second, minute, and hour
--				 counter.
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library Task4;
use Task4.all;

entity clock_chain is
	port(
		rst_n : in std_logic; 			-- active low synchronous reset
		clk : in std_logic; 			-- system clock
		clr_n : in std_logic; 			-- active low synchronous clear
		load_sec_en : in std_logic; 	-- parallel load active high
		load_min_en : in std_logic; 	-- parallel load active high
		load_hour_en : in std_logic; 	-- parallel load active high
		setting_sec : in std_logic_vector(6 downto 0); 	-- load value 
		setting_min : in std_logic_vector(6 downto 0); 	-- load value 
		setting_hour : in std_logic_vector(5 downto 0); -- load value 
		cnt_en_1 : in std_logic; 		-- enable count 1
		cnt_en_2 : in std_logic; 		-- enable count 2
		max_count : out std_logic; 		-- maximum count flag
		count_sec : out std_logic_vector(6 downto 0); 	-- BCD count
		count_min : out std_logic_vector(6 downto 0); 	-- BCD count
		count_hour : out std_logic_vector(5 downto 0) 	-- BCD count
	);
end clock_chain;

architecture structural of clock_chain is
-- local signal declarations
signal cnt_en_1_min, cnt_en_1_hour: std_logic;
signal max_count_sec, max_count_min, max_count_hour: std_logic;
begin
	u2: entity modulo_60_counter port map (rst_n => rst_n, clk => clk, clr_n => clr_n, load_en => load_sec_en, setting => setting_sec, cnt_en_1 => cnt_en_1, cnt_en_2 => cnt_en_2, max_count => max_count_sec, count => count_sec);
	u3: entity modulo_60_counter port map (rst_n => rst_n, clk => clk, clr_n => clr_n, load_en => load_min_en, setting => setting_min, cnt_en_1 => cnt_en_1_min, cnt_en_2 => cnt_en_2, max_count => max_count_min, count => count_min);
	u4: entity modulo_24_counter port map (rst_n => rst_n, clk => clk, clr_n => clr_n, load_en => load_hour_en, setting => setting_hour, cnt_en_1 => cnt_en_1_hour, cnt_en_2 => cnt_en_2, max_count => max_count_hour, count => count_hour);
	
	block_69:
		cnt_en_1_min <= max_count_sec and cnt_en_1;
	block_70:
		cnt_en_1_hour <= max_count_min and max_count_sec and cnt_en_1;
	block_71:
		max_count <= max_count_hour and max_count_min and max_count_sec;
		
end structural;
