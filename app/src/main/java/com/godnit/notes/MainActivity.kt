package com.godnit.notes

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val layout = LinearLayout(this)
        layout.orientation = LinearLayout.VERTICAL

        val input = EditText(this)
        input.hint = "اكتب ملاحظة"

        val button = Button(this)
        button.text = "حفظ"

        val list = TextView(this)

        button.setOnClickListener {
            list.text = list.text.toString() + "\n" + input.text.toString()
            input.text.clear()
        }

        layout.addView(input)
        layout.addView(button)
        layout.addView(list)
        setContentView(layout)
    }
}
