#include "stdafx.h"

bool th125mission_convert_impl(unsigned char *data, unsigned char level, unsigned char number, unsigned char player, unsigned char line){
	BOOST_ASSERT(data);
	unsigned char a = static_cast<unsigned char>(13 * player + 11 * number + 7 * level + 58);
	const unsigned char b = static_cast<unsigned char>(23 * line);
	for(unsigned int i = 0; i < 64; i++){
		data[i] += a;
		a += static_cast<unsigned char>(b + 23 + i);
	}
	return true;
}

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Player : boost::noncopyable {
public:
	enum PLAYER_NAME{
		PLAYER_NAME_AYA = 0,
		PLAYER_NAME_HATATE,
	};
	Player(PLAYER_NAME player, unsigned char img_no, const char *clear_message) :
		player(player), img_no(img_no), clear_message(clear_message, &clear_message[strlen(clear_message) + 1])
	{
	}
	const char *Name(void) const {
		const char * const name_list[2] = {"aya", "hatate"};
		return name_list[static_cast<unsigned int>(player)];
	}
	unsigned char ImageNumber(void) const { // ImageNumero‚É‚·‚é‚©–À‚Á‚½‚¯‚ÇA‚ ‚Æ‚Åâ‘Î¬—‚·‚é‚Ì‚Å‚±‚Á‚¿‚Å
		return img_no;
	}
	const char *ClearMessage(void) const {
		BOOST_ASSERT(clear_message.size() > 0);
		return &clear_message.front();
	}
protected:
	const PLAYER_NAME player;
	const unsigned char img_no;
	unsigned char padding[3]; // unused
	const std::vector<char> clear_message;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, const Player &player) {
	char out_str_head[256];
	SPRINTF(out_str_head,
"      - name: %s\n"
"        img_no: %d\n"
"        clear_message: |-\n", player.Name(), player.ImageNumber());
	out << out_str_head;

	char message_lines[6][64] = {{""}, {""}, {""}, {""}, {""}, {""}};
	const char *start, *end;
	start = player.ClearMessage();
	for(unsigned int i = 0; i < 6 && *start != '\0'; i++) {
		end = ::strchr(start, '\n');
		if(end == NULL) {
			end = &start[strlen(start)];
		}
		strncpy_s(message_lines[i], sizeof(message_lines[i]), start, static_cast<unsigned int>(end - start));
		start = end;
		if(*start == '\n') {
			start++;
		}
	}
	for(unsigned int i = 0; i < 6 && message_lines[i][0] != '\0'; i++) {
		char out_str[74];
		SPRINTF(out_str, "          %s\n", message_lines[i]);
		out << out_str;
	}
	return out;
}

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Stage : boost::noncopyable {
public:
	Stage(unsigned short number, unsigned char photo_count, unsigned int norma, unsigned int unknown) :
		number(number), photo_count(photo_count), norma(norma), unknown(unknown), player_list(2)
	{
	}
	std::shared_ptr<Player> &operator [](Player::PLAYER_NAME index) {
		return player_list[static_cast<unsigned int>(index)];
	}
	const std::shared_ptr<Player> &operator [](Player::PLAYER_NAME index) const {
		return player_list[static_cast<unsigned int>(index)];
	}
	unsigned short Number(void) const {
		return number;
	}
	unsigned char PhotoCount(void) const {
		return photo_count;
	}
	unsigned int Norma(void) const {
		return norma;
	}
	unsigned int Unknown(void) const {
		return unknown;
	}
protected:
	const unsigned short number;
	const unsigned char photo_count;
	unsigned char padding[1]; // unused
	const unsigned int norma;
	const unsigned int unknown;
	std::vector<std::shared_ptr<Player> > player_list;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, const Stage &stage) {
	char out_str[256];
	SPRINTF(out_str,
"  - number: %d\n"
"    photo_count: %d\n"
"    norma: %d\n"
"    unknown: %d\n"
"    player:\n", stage.Number(), stage.PhotoCount(), stage.Norma(), stage.Unknown());
	out << out_str;
	out << *stage[Player::PLAYER_NAME_AYA];
	out << *stage[Player::PLAYER_NAME_HATATE];
	return out;
}

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class StageList : boost::noncopyable {
public:
	StageList(unsigned int level) :
		level(level)
	{
		BOOST_ASSERT(level == 98 || level < 14);
	}
	void Resize(unsigned int size) {
		list.resize(size);
	}
	unsigned int Size(void) const {
		return list.size();
	}
	unsigned int Level(void) const {
		return level;
	}
	std::shared_ptr<Stage> &operator [](unsigned int index) {
		return list[index];
	}
	const std::shared_ptr<Stage> &operator [](unsigned int index) const {
		return list[index];
	}
protected:
	const unsigned int level;
	std::vector<std::shared_ptr<Stage> > list;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, const StageList &stage_list) {
	char out_str[256];
	SPRINTF(out_str,
"- level: %d\n"
"  stage:\n", stage_list.Level());
	out << out_str;
	for(unsigned int i = 0; i < stage_list.Size(); i++) {
		if(stage_list[i]) {
			out << *stage_list[i];
		}
	}
	return out;
}

std::ostream &operator<<(std::ostream &out, const std::vector<std::shared_ptr<StageList> > level_list) {
	for (std::shared_ptr<StageList> stage_list : level_list) {
		if(stage_list) {
			out << *stage_list;
		}
	}
	return out;
}

bool Parse(std::vector<std::shared_ptr<StageList> > &level_list, const std::vector<unsigned char> &data) {
	if(data.size() < 4) {
		return false;
	}
	level_list.resize(15);
	const unsigned int msg_count = *reinterpret_cast<const unsigned int *>(&data[0]);
	if(data.size() < 4 + msg_count * 4) {
		return false;
	}
	for(unsigned int i = 0; i < msg_count; i++) {
		const unsigned int base_addr = *reinterpret_cast<const unsigned int *>(&data[4 + i * 4]);
		if(data.size() < base_addr + 16 + 8 * 3 + 64 * 6) {
			return false;
		}
		const unsigned char *base_ptr = &data[base_addr];
		const unsigned short level = *reinterpret_cast<const unsigned short *>(&base_ptr[0]);
		const unsigned int stage_index = static_cast<unsigned int>(level == 98 ? 14 : level);
		if(!level_list[stage_index]) {
			level_list[stage_index].reset(new StageList(level));
		}
		const unsigned short number = *reinterpret_cast<const unsigned short *>(&base_ptr[2]);
		const unsigned char photo_count = base_ptr[7];
		const unsigned int norma = *reinterpret_cast<const unsigned int *>(&base_ptr[8]);
		const unsigned int unknown = *reinterpret_cast<const unsigned int *>(&base_ptr[12]);
		if(level_list[stage_index]->Size() <= number) {
			level_list[stage_index]->Resize(static_cast<unsigned int>(number + 1));
		}
		if(!(*level_list[stage_index])[number]) {
			(*level_list[stage_index])[number].reset(new Stage(number, photo_count, norma, unknown));
		}
		const unsigned short player_id = *reinterpret_cast<const unsigned short *>(&base_ptr[4]);
		const Player::PLAYER_NAME player = static_cast<Player::PLAYER_NAME>(player_id);
		const unsigned char img_no = base_ptr[6];
		char clear_message[64 * 6 + 1] = "";
		for(unsigned int line = 0; line < 3; line++) {
			if(base_ptr[16 + line * 8] != 0xFF) {
				const unsigned int pos = *reinterpret_cast<const unsigned int *>(&base_ptr[16 + line * 8]);
				const unsigned int space = *reinterpret_cast<const unsigned int *>(&base_ptr[16 + line * 8 + 4]);
				unsigned char ruby_data[64];
				::memcpy(ruby_data, &base_ptr[40 + (line + 3) * 64], 64);
				const bool convert_result = th125mission_convert_impl(ruby_data, static_cast<unsigned char>(level), static_cast<unsigned char>(number), static_cast<unsigned char>(player), static_cast<unsigned char>(line + 3));
				if(!convert_result) {
					return false;
				}
				STRCATF(clear_message, "|%d,%d,%s\n", pos, space, ruby_data);

			}
			unsigned char line_data[64];
			::memcpy(line_data, &base_ptr[40 + line * 64], 64);
			const bool convert_result = th125mission_convert_impl(line_data, static_cast<unsigned char>(level), static_cast<unsigned char>(number), static_cast<unsigned char>(player), static_cast<unsigned char>(line));
			if(!convert_result) {
				return false;
			}
			STRCAT(clear_message, reinterpret_cast<char *>(line_data));
			if(line < 2) {
				STRCAT(clear_message, "\n");
			}
		}
		(*(*level_list[stage_index])[number])[player].reset(new Player(player, img_no, clear_message));
	}
	return true;
}

bool th125mission_convert(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {
	std::vector<std::shared_ptr<StageList> > level_list;
	const bool parse_result = Parse(level_list, data);
	if(!parse_result) {
		return false;
	}
	char put_filename[256];
	SPRINTF(put_filename, "data/%s", file_data->fn);
	char * const file_ext = ::PathFindExtensionA(put_filename);
	*file_ext = '\0';
	STRCAT(put_filename, ".txt");
	std::ofstream out(put_filename);
	out << level_list;
	out.close();
	return true;
}
