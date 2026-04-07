# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Очищаем базу..."
Edge.destroy_all
Place.destroy_all
Node.destroy_all

puts "Создаём узлы..."

# --- Узлы для мест ---
nodes_data = [
  { lat: 56.9460, lng: 24.1059 },  # Рига, центр
  { lat: 57.0000, lng: 24.7994 },  # Сигулда
  { lat: 57.3120, lng: 25.2842 },  # Цесис
  { lat: 57.5353, lng: 25.4186 },  # Валмиера
  { lat: 56.5100, lng: 27.3400 },  # Резекне
  { lat: 55.8700, lng: 26.5300 },  # Даугавпилс
  { lat: 56.6500, lng: 23.7200 },  # Елгава
  { lat: 57.1500, lng: 21.9900 },  # Вентспилс
  { lat: 56.5100, lng: 21.0100 },  # Лиепая
  { lat: 57.0900, lng: 24.5000 },  # Икшкиле
  # Промежуточные узлы дорог
  { lat: 56.9750, lng: 24.4000 },  # дорога Рига→Сигулда (1)
  { lat: 56.9900, lng: 24.6000 },  # дорога Рига→Сигулда (2)
  { lat: 57.1500, lng: 25.0000 },  # дорога Сигулда→Цесис
  { lat: 57.4200, lng: 25.3500 },  # дорога Цесис→Валмиера
]

nodes = nodes_data.map do |d|
  Node.create!(latitude: d[:lat], longitude: d[:lng])
end

puts "Создаём места..."

places_data = [
  { name: "Старая Рига", description: "Исторический центр, внесён в список ЮНЕСКО", category: "city", node_i: 0 },
  { name: "Сигулдский замок", description: "Средневековый замок Ливонского ордена", category: "castle", node_i: 1 },
  { name: "Цесисский замок", description: "Хорошо сохранившийся замок XIII века", category: "castle", node_i: 2 },
  { name: "Валмиера", description: "Спокойный город на реке Гауя", category: "city", node_i: 3 },
  { name: "Резекне", description: "Город в сердце Латгалии", category: "city", node_i: 4 },
  { name: "Даугавпилс", description: "Крепость и арт-центр Марка Ротко", category: "city", node_i: 5 },
  { name: "Rundāles pils", description: "Барочный дворец архитектора Растрелли", category: "castle", node_i: 6 },
  { name: "Вентспилс", description: "Портовый город с янтарными пляжами", category: "beach", node_i: 7 },
  { name: "Лиепая", description: "Город, где рождается ветер", category: "beach", node_i: 8 },
  { name: "Икшкильская ГЭС", description: "Панорама Даугавы с острова", category: "viewpoint", node_i: 9 },
]

places_data.each do |p|
  Place.create!(
    name: p[:name],
    description: p[:description],
    category: p[:category],
    node: nodes[p[:node_i]]
  )
end

puts "Создаём рёбра (дороги)..."

edges_data = [
  [0, 10, 25_000],   # Рига → промежуток 1
  [10, 11, 18_000],  # промежуток 1 → промежуток 2
  [11, 1,  20_000],  # промежуток 2 → Сигулда
  [1,  12, 30_000],  # Сигулда → промежуток
  [12, 2,  25_000],  # промежуток → Цесис
  [2,  13, 22_000],  # Цесис → промежуток
  [13, 3,  18_000],  # промежуток → Валмиера
  [0,  9,  35_000],  # Рига → Икшкиле
  [0,  6,  45_000],  # Рига → Елгава
]

edges_data.each do |from_i, to_i, dist|
  # Создаём в обе стороны — дороги двусторонние
  Edge.create!(from_node: nodes[from_i], to_node: nodes[to_i], distance: dist)
  Edge.create!(from_node: nodes[to_i], to_node: nodes[from_i], distance: dist)
end

puts "Готово! #{Node.count} узлов, #{Place.count} мест, #{Edge.count} рёбер"