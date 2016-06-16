package com.zhuhai.utils;

import com.dyuproject.protostuff.LinkedBuffer;
import com.dyuproject.protostuff.ProtostuffIOUtil;
import com.dyuproject.protostuff.Schema;
import com.dyuproject.protostuff.runtime.RuntimeSchema;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/16
 * Time: 11:42
 */
public class ProtostuffUtil {

    private static Map<Class<?>,Schema<?>> schemaMap = new ConcurrentHashMap<Class<?>, Schema<?>>();

    /**
     * 获取Schema
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> Schema<T> getSchema(Class<T> clazz) {
        Schema<T> schema = (Schema<T>) schemaMap.get(clazz);
        if (schema == null) {
            schema = RuntimeSchema.getSchema(clazz);
            if (schema != null) {
                schemaMap.put(clazz,schema);
            }
        }
        return schema;
    }

    /**
     * 序列化
     * @param obj
     * @param <T>
     * @return byte[]
     */
    public static <T> byte[] serializer(T obj){
        Class<T> clazz = (Class<T>) obj.getClass();
        LinkedBuffer buffer = LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE);
        try {
            Schema<T> schema = getSchema(clazz);
            return ProtostuffIOUtil.toByteArray(obj,schema,buffer);
        } catch (Exception e) {
            throw new IllegalStateException(e.getMessage(),e);
        } finally {
            buffer.clear();
        }
    }

    /**
     * 反序列化
     * @param data
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T deserializer(byte[] data,Class<T> clazz){
        try {
            T obj = clazz.newInstance();
            Schema<T> schema = getSchema(clazz);
            ProtostuffIOUtil.mergeFrom(data,obj,schema);
            return obj;
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalStateException(e.getMessage(),e);
        }

    }
}
