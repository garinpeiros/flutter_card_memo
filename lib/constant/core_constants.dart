import '../model/select_item.dart';

const int LoadLimit = 20;

const List<SelectItem> CategoryItems = <SelectItem>[
  const SelectItem(
    1,
    'キャラクター',
    'blue',
  ),
  const SelectItem(
    2,
    'セリフ',
    'yellow',
  ),
  const SelectItem(
    3,
    '構成',
    'green',
  ),
  const SelectItem(
    4,
    'ストーリー',
    'red',
  ),
  const SelectItem(
    5,
    '小ネタ・アイテム',
    'purple',
  )
];

const List<SelectItem> DoramaCategoryItems = <SelectItem>[
  const SelectItem(
    1,
    'シネマ',
    'blue',
  ),
  const SelectItem(
    2,
    'テレビ',
    'yellow',
  ),
  const SelectItem(
    3,
    'マンガ',
    'green',
  ),
  const SelectItem(
    4,
    'その他',
    'gray',
  ),
];
