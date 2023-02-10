-------------------------------------------------------------------------------
--
-- Title       : rtc_parallel_load_one_sec
-- Design      : Task4
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab11\Task 4\Task4\Task4\src\rtc_parallel_load_one_sec.vhd
-- Generated   : Mon Apr 26 23:52:59 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for an RTC with parallel load.
--				 Now, the one second prescaler is implemented so that it may
--				 run off of a 32.768kHz crystal oscillator source.
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library Task4;
use Task4.all;

entity rtc_parallel_load_one_sec is
	port(
		rst_n : in std_logic; 			-- active low synchronous reset
		clk : in std_logic; 			-- system clock
		clr_n : in std_logic; 			-- active low synchronous clear
		address : in std_logic_vector(3 downto 0);
		data : in std_logic_vector(6 downto 0);
		wr_n : in std_logic; 			-- write control strobe, active low
		cs_n : in std_logic; 			-- chip select strobe, active low
		f32768hz : in std_logic; 		-- 32.768 kHz oscillator input
		max_count : out std_logic;		-- max count
		one_hz : out std_logic; 		-- one Hz output square wave
		count_sec : out std_logic_vector(6 downto 0); -- BCD sec count
		count_min : out std_logic_vector(6 downto 0); -- BCD min count
		count_hour : out std_logic_vector(5 downto 0) -- BCD hour count
	);
	
	
	attribute loc: string; 
	attribute loc of f32768hz: signal is "D3";
	attribute loc of rst_n: signal is "F1";
	attribute loc of clk: signal is "J1";
	attribute loc of clr_n: signal is "C2";
	attribute loc of cs_n: signal is "E10";
	attribute loc of wr_n: signal is "B4";

	attribute loc of data: signal is "A13,F8,C12,F9,E8,E7,D7";
	attribute loc of address: signal is "C5,E6,A10,D9";

	attribute loc of one_hz: signal is "B5";
	attribute loc of max_count: signal is "D6";
	attribute loc of count_sec: signal is "A3,A4,A5,B7,B9,F7,C4";
	attribute loc of count_min: signal is "B1, E3, F5,F2,E2,D2,C1";
	attribute loc of count_hour: signal is "H2,G2,L3,K4,K1,J3";

end rtc_parallel_load_one_sec;


architecture structure of rtc_parallel_load_one_sec is
-- local signal declarations
signal run_clock_chain, a_pe_to_wr, s_to_y4, r_to_y0: std_logic;
signal y1_to_loadsec, y2_to_loadmin, y3_to_loadhour: std_logic;
signal y5to9: std_logic_vector(4 downto 0);
signal data7: std_logic;
signal onesectick_to_cnten1: std_logic;
begin
--	u5: entity pos_edge_detector port map (a => wr_n, rst_n => rst_n, clk => clk, a_pe => a_pe_to_wr);
--	u6:	entity write_address_decoder port map (cs_n => cs_n, address => address, wr => a_pe_to_wr, y(0) => r_to_y0, y(1) => y1_to_loadsec, y(2) => y2_to_loadmin, y(3) => y3_to_loadhour, y(4) => s_to_y4, y(9 downto 5) => y5to9); 
--	u7: entity s_r_flip_flop port map (clk => clk, rst_n => rst_n, q => run_clock_chain, s => s_to_y4, r => r_to_y0);
--	u8: entity clock_chain port map (rst_n => rst_n, clk => clk, clr_n => clr_n, setting_sec => data(6 downto 0), setting_min => data(6 downto 0), setting_hour => data(5 downto 0), cnt_en_1 => onesectick_to_cnten1, cnt_en_2 => run_clock_chain, max_count => max_count, count_sec => count_sec, count_min => count_min, count_hour => count_hour, load_sec_en => y1_to_loadsec, load_min_en => y2_to_loadmin, load_hour_en => y3_to_loadhour);
--	u9: entity one_sec_counter port map (f32768hz => f32768hz, clk => clk, rst_n => rst_n, clr_n => clr_n, one_sec_tick => onesectick_to_cnten1, one_hz => one_hz);

	u10: entity rtc_parallel_load port map (rst_n => rst_n, clk => clk, clr_n => clr_n, data(7) => data7, data(6 downto 0) => data(6 downto 0), address => address, wr_n => wr_n, cs_n => cs_n, max_count => max_count, count_sec => count_sec, count_min => count_min, count_hour => count_hour , cnt_en_1 => onesectick_to_cnten1);
	u11: entity one_sec_counter port map (f32768hz => f32768hz, clk => clk, rst_n => rst_n, clr_n => clr_n, one_sec_tick => onesectick_to_cnten1, one_hz => one_hz); 
	
end structure;