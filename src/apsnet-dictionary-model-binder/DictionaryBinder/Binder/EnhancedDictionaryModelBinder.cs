using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ModelBinding.Binders;
using System.Text.Json;

namespace DictionaryBinder.Controllers;

public class EnhancedDictionaryModelBinder<TKey, TValue> : IModelBinder
{
    private readonly DictionaryModelBinder<TKey, TValue> _binder;

    public EnhancedDictionaryModelBinder(DictionaryModelBinder<TKey, TValue> binder)
    {
        _binder = binder;
    }

    public async Task BindModelAsync(ModelBindingContext bindingContext)
    {
        await _binder.BindModelAsync(bindingContext);

        var model = (IDictionary<TKey, TValue>)bindingContext.Result.Model;
        if (model != null && model.Count > 0)
        {
            return;
        }

        var values = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
        foreach (var val in values)
        {
            var dictionary = JsonSerializer.Deserialize<Dictionary<TKey, TValue>>(val);
            foreach (var kv in dictionary)
            {
                if (!model.ContainsKey(kv.Key))
                {
                    model[kv.Key] = kv.Value;
                }
            }
        }
    }
}
