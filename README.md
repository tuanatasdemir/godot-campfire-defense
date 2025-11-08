# Ghost Defense Mini-Game (Godot 4)

Bu proje, Godot 4 oyun motoru kullanılarak geliştirilmiş, "Clicker" ve "Tower Defense" mekaniklerini birleştiren bir prototiptir. Bilgisayar Mühendisliği eğitimi kapsamında; Nesne Yönelimli Programlama (OOP), Olay Güdümlü Mimari (Event-Driven Architecture) ve temel oyun matematiği (Vektörler) konularının pratik uygulamasını göstermek amacıyla geliştirilmiştir.

## Projenin Amacı ve Kapsamı

Projenin temel amacı, hazır tutorial'lara bağlı kalmadan, bir oyun döngüsünü (Game Loop) sıfırdan inşa etmektir.
Oyuncu, merkezdeki kamp ateşini, ekranın rastgele noktalarından gelen hayaletlere tıklayarak 10 saniye boyunca korumalıdır.

## Teknik Kazanımlar ve Mimari

Proje, modüler ve genişletilebilir bir kod yapısı gözetilerek tasarlanmıştır:

### 1\. Object-Oriented Spawner System (Fabrika Tasarım Deseni)

Düşman üretimi için merkezi bir `Spawner` sınıfı geliştirilmiştir.

  * **Decoupling:** Spawner, ne ürettiğini bilmez (`PackedScene` ile soyutlanmıştır).
  * **Scalability:** Sahneye birden fazla Spawner eklenerek farklı düşman türleri veya farklı spawn noktaları kolayca oluşturulabilir.
  * **Randomization:** Düşmanlar ekranın dışındaki rastgele koordinatlarda, `Vector2` matematiği ile oluşturulur.

### 2\. Event-Driven Communication (Sinyaller ve Gruplar)

Oyun içi objeler birbirine sıkı sıkıya bağlı (tightly coupled) değildir. Haberleşme sinyaller ve gruplar üzerinden sağlanır:

  * **Ghost -\> GameManager:** Hayalet hedefe ulaştığında, `get_tree().call_group("GameManager", "game_over")` ile oyun yöneticisine sinyal gönderir. Bu sayede hayalet, oyun yöneticisinin kim olduğunu bilmek zorunda kalmaz.
  * **Timer -\> Spawner:** Düşman üretim sıklığı `Timer` düğümünün `timeout` sinyali ile kontrol edilir.

### 3\. Vector-Based Movement AI

Düşmanların hareketi, hedef odaklı vektör matematiği ile sağlanmıştır:

```gdscript
var direction = (target_position - global_position).normalized()
global_position += direction * speed * delta
```

Bu sayede düşmanlar, hedefin konumu değişse bile dinamik olarak rotalarını güncelleyebilirler.

### 4\. Game State Management

Oyunun `Win` (Kazanma) ve `Lose` (Kaybetme) durumları, ana yönetici (`Main.gd`) üzerinde boolean flag'ler ve state kontrolleri ile yönetilir. `AnimationPlayer` ve `Tween` kullanılarak durum geçişlerinde görsel geri bildirimler (UI animasyonları) sağlanmıştır.

### 5\. Audio Management (Singleton Pattern)

Ses efektleri, performans optimizasyonu için global bir `AudioManager` (Singleton) üzerinden yönetilir. Bu sayede her ses için yeni bir obje yaratıp yok etme maliyetinden kaçınılmıştır.

##  Nasıl Oynanır?

1.  Oyunu başlatın.
2.  Kamp ateşine doğru gelen hayaletlere farenin sol tuşu ile tıklayarak onları yok edin.
3.  10 saniye boyunca ateşi korumayı başarırsanız kazanırsınız.
4.  Tek bir hayalet bile ateşe ulaşırsa oyun biter.
