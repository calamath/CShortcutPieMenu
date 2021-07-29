--
-- Calamath's Shortcut Pie Menu [CSPM]
--
-- Copyright (c) 2021 Calamath
--
-- This software is released under the Artistic License 2.0
-- https://opensource.org/licenses/Artistic-2.0
--
-- Note :
-- This addon works that uses the library LibAddonMenu-2.0 by sirinsidiator, Seerah, released under the Artistic License 2.0
-- You will need to obtain the above libraries separately.
--

-- Japanese Translations

-- Key Bindings --
SafeAddString(SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION,	"|c7CFC00パイメニュー 第１アクション|r", 1)
SafeAddString(SI_BINDING_NAME_CSPM_PIE_MENU_SECONDARY,		"|cC5C292パイメニュー 第２アクション|r", 1)
SafeAddString(SI_BINDING_NAME_CSPM_PIE_MENU_TERTIARY,		"|cC5C293パイメニュー 第３アクション|r", 1)
SafeAddString(SI_BINDING_NAME_CSPM_PIE_MENU_QUATERNARY,		"|cC5C294パイメニュー 第４アクション|r", 1)
SafeAddString(SI_BINDING_NAME_CSPM_PIE_MENU_QUINARY,		"|cC5C295パイメニュー 第５アクション|r", 1)

-- Common Strings --
SafeAddString(SI_CSPM_COMMON_PRESET,						"プリセット", 1)
SafeAddString(SI_CSPM_COMMON_SLOT,							"スロット", 1)
SafeAddString(SI_CSPM_COMMON_UNSELECTED,					"<未選択>", 1)
SafeAddString(SI_CSPM_COMMON_UNREGISTERED,					"<未登録>", 1)
SafeAddString(SI_CSPM_COMMON_IMMEDIATE_VALUE,				"(即値)", 1)
SafeAddString(SI_CSPM_COMMON_COLLECTIBLE,					"コレクション", 1)
SafeAddString(SI_CSPM_COMMON_EMOTE,							"エモート", 1)
SafeAddString(SI_CSPM_COMMON_CHAT_COMMAND,					"チャットコマンド", 1)
SafeAddString(SI_CSPM_COMMON_TRAVEL_TO_HOUSE,				"家に行く", 1)
SafeAddString(SI_CSPM_COMMON_MY_HOUSE_INSIDE,				"自宅（中）", 1)
SafeAddString(SI_CSPM_COMMON_MY_HOUSE_OUTSIDE,				"自宅（外）", 1)
SafeAddString(SI_CSPM_COMMON_PIE_MENU,						"パイメニュー", 1)
SafeAddString(SI_CSPM_COMMON_UI_FORMATTER,					"<<1>> <<2>> <<3>> <<4>> <<5>> <<6>>", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION0,					"<<1>> <<2>>", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION1,					"<<1>> <<2>> を開く", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION2,					"<<1>> <<2>> を閉じる", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION3,					"<<1>> <<2>> をコピー", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION4,					"<<1>> <<2>> を貼り付け", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION5,					"<<1>> <<2>> をクリア", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION6,					"<<1>> <<2>> をリセット", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION7,					"<<1>> <<2>> をプレビュー", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION8,					"<<1>> <<2>> を選択", 1)
SafeAddString(SI_CSPM_COMMON_UI_ACTION9,					"<<1>> <<2>> をキャンセル", 1)

-- CShortcut PieMenu Editor UI --
SafeAddString(SI_CSPM_UI_PANEL_HEADER1_TEXT,				"このアドオンは、様々なUI操作のショートカットとしてパイメニューを提供します。", 1)
SafeAddString(SI_CSPM_UI_PANEL_HEADER2_TEXT,				"このパネルでは、パイメニューの各スロットにお気に入りのショートカットを設定し、それをパイメニューのプリセットとして登録し、アカウント全体で使用することができます。\n", 1)
SafeAddString(SI_CSPM_UI_PRESET_SELECT_MENU_NAME,			"プリセットの選択", 1)
SafeAddString(SI_CSPM_UI_PRESET_SELECT_MENU_TIPS,			"設定したいプリセット番号を選択してください。", 1)
SafeAddString(SI_CSPM_UI_PRESET_VISUAL_SUBMENU_TIPS,		"プリセットごとにパイメニューのビジュアルデザインを調整します。（オプション）", 1)
SafeAddString(SI_CSPM_UI_MENU_ITEMS_COUNT_OP_NAME,			"メニュー項目数", 1)
SafeAddString(SI_CSPM_UI_MENU_ITEMS_COUNT_OP_TIPS,			"パイメニューに表示するスロットの数を選択します。", 1)
SafeAddString(SI_CSPM_UI_SLOT_SELECT_MENU_NAME,				"スロットの選択", 1)
SafeAddString(SI_CSPM_UI_SLOT_SELECT_MENU_TIPS,				"設定したいスロット番号を選択してください。", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_MENU_NAME,				"アクションタイプ", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_MENU_TIPS,				"このスロットの動作の種類を選択します", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_NOTHING_TIPS,			"", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_TIPS,		"アンロックされたコレクションを使う。", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_EMOTE_TIPS,			"エモート（感情表現）を再生する。", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_CHAT_COMMAND_TIPS,		"チャットコマンドを実行する。", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_TRAVEL_TO_HOUSE_TIPS,	"アンロックされた自宅に高速移動する", 1)
SafeAddString(SI_CSPM_UI_ACTION_TYPE_PIE_MENU_TIPS,			"パイメニューの別のプリセットを開く", 1)
SafeAddString(SI_CSPM_UI_CATEGORY_MENU_NAME,				"カテゴリー", 1)
SafeAddString(SI_CSPM_UI_CATEGORY_MENU_TIPS,				"<Category menu tips>", 1)
SafeAddString(SI_CSPM_UI_ACTION_VALUE_MENU_NAME,			"値", 1)
SafeAddString(SI_CSPM_UI_ACTION_VALUE_MENU_TIPS,			"<Action Value tips>", 1)
SafeAddString(SI_CSPM_UI_ACTION_VALUE_EDITBOX_TIPS,			"アクションの値を直接入力したい場合は、ここに入力してください（上級者向け）。", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SLOT_NAME_OVERRIDE_NAME,	"スロット名の上書き指定", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SLOT_NAME_OVERRIDE_TIPS,	"このスロットの名称をお好みに調整する（オプション）", 1)
SafeAddString(SI_CSPM_UI_DEFAULT_SLOT_NAME_BUTTON_NAME,		"デフォルト名", 1)
SafeAddString(SI_CSPM_UI_DEFAULT_SLOT_NAME_BUTTON_TIPS,		"選択したアクションに対応するデフォルトのスロット名を上のエディットボックスに挿入します。", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SLOT_ICON_OVERRIDE_NAME,	"スロットアイコンの上書き指定", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SLOT_ICON_OVERRIDE_TIPS,	"このスロットのアイコンをお好みに調整する。アイコンを置き換えるために、Esouiで始まるアイコン画像ファイルのフルパス名を入力します。（オプション）", 1)

SafeAddString(SI_CSPM_UI_VISUAL_PRESET_NAME_OVERRIDE_NAME,	"プリセット名の上書き指定", 1)
SafeAddString(SI_CSPM_UI_VISUAL_PRESET_NAME_OVERRIDE_TIPS,	"このプリセットの名称をお好みに調整する（オプション）", 1)
SafeAddString(SI_CSPM_UI_VISUAL_PRESET_NOTE_NAME,			"プリセットに関するメモ", 1)
SafeAddString(SI_CSPM_UI_VISUAL_PRESET_NOTE_TIPS,			"このプリセットについてのメモを調整する（オプション）", 1)
SafeAddString(SI_CSPM_UI_VISUAL_HEADER1_TEXT,				"ビジュアルデザイン設定", 1)
SafeAddString(SI_CSPM_UI_VISUAL_QUICKSLOT_STYLE_OP_NAME,	"クイックスロットのラジアルメニュー風のスタイル", 1)
SafeAddString(SI_CSPM_UI_VISUAL_QUICKSLOT_STYLE_OP_TIPS,	"クイックスロットのラジアルメニューのような背景デザインを適用します。", 1)
SafeAddString(SI_CSPM_UI_VISUAL_GAMEPAD_STYLE_OP_NAME,		"ゲームパッドモードのラジアルメニュー風のスタイル", 1)
SafeAddString(SI_CSPM_UI_VISUAL_GAMEPAD_STYLE_OP_TIPS,		"ゲームパッドモードのラジアルメニューのような背景デザインを適用します。", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SHOW_PRESET_NAME_OP_NAME,	"プリセット名の表示", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SHOW_PRESET_NAME_OP_TIPS,	"パイメニューの下にプリセット名を表示するかどうか。", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SHOW_SLOT_NAME_OP_NAME,		"スロット名の表示", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SHOW_SLOT_NAME_OP_TIPS,		"パイメニューの周りに各スロットの名称を表示するかどうか。", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SHOW_ICON_FRAME_OP_NAME,	"アイコン枠の表示", 1)
SafeAddString(SI_CSPM_UI_VISUAL_SHOW_ICON_FRAME_OP_TIPS,	"パイメニューの各スロットにアイコン枠を表示するかどうか。", 1)

-- CShortcut PieMenu Manager UI --
SafeAddString(SI_CSPM_UI_PANEL_HEADER3_TEXT,				"このパネルでは、様々なUIイベントのトリガーに対して、どのパイメニューが呼び出されるかを設定できます。", 1)
SafeAddString(SI_CSPM_UI_ACCOUNT_WIDE_OP_NAME,				"アカウント共通の設定を使う", 1)
SafeAddString(SI_CSPM_UI_ACCOUNT_WIDE_OP_TIPS,				"アカウント共通の設定をOFFにすると、キャラクターごとに以下の設定が可能になります。", 1)
SafeAddString(SI_CSPM_UI_BINDINGS_HEADER1_TEXT,				"キーバインドとプリセットの関連付け設定", 1)
SafeAddString(SI_CSPM_UI_BINDINGS_HEADER1_TIPS,				"各ショートカットキーには、お好みのパイメニューを割り当てることができます。もちろん、システムメニューの「操作」の設定で、このアドオンのアクションにキー操作を割り当てておく必要があります。", 1)
SafeAddString(SI_CSPM_UI_BINDINGS_INTERACTION1_TIPS,		"これは、このアドオンに割り当てなければならない「パイメニュー 第1アクション」のキーバインドに紐付けるプリセットの設定です。基本的には、最も頻繁に使用されるパイメニューのプリセットを割り当てるべきですが、後述のイベントトリガーにより、アドオンがパイメニューのプリセットを自動的に切り替えることもあります。", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_HEADER1_TEXT,				"動作オプション（上級者向け）", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_HEADER1_TIPS,				"これらは、開発中のプロトタイプ機能など、通常は変更する必要のないオプション設定です。現在調整中のオプション設定はベータ版として表示され、今後の調整に対する積極的なフィードバックが歓迎されます。(上級者向け)", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_NAME,	"起動するまでのキー保持時間（ミリ秒）", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_TIPS,	"パイメニュー起動時のキーホールド時間を調整することができます。数字が小さいほど高速になります。", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_NAME,	"UIモードでパイメニューを有効にする", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_TIPS,	"パイメニューを、ほとんどのUIモード（カーソルモード）のシーンで有効にできるようにします。", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_NAME,		"クリックによる選択とキャンセル", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_TIPS,		"この設定をオンにすると、マウスボタンやゲームパッドのボタンでパイメニューの選択やキャンセルが素早くできるようになります。\n\nメニュー選択：マウスの左ボタン，ゲームパッドのＡボタン\nキャンセル：マウスの右ボタン，ゲームパッドのＢボタン，ＥＳＣキー", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_NAME,	"UIモードでマウスカーソルの中心に置く", 1)
SafeAddString(SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_TIPS,	"この設定をオンにすると、UIモードではパイメニューが画面の中央ではなく、現在のマウスカーソルの位置に表示されます。", 1)

