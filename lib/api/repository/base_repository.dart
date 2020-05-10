abstract class BaseRepository<T> {

  Future<List<T>> fetch();
  Future<T> getById(int id);
  Future<T> update(int id);
  Future<int> delete(int id);
}